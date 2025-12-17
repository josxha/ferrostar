import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MapPage());
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _start = LatLng(47.6603, 9.1758); // Konstanz
  static const _dest = LatLng(47.6735, 9.1719); // Kreuzlingen

  List<LatLng> _routePoints = const [];
  bool _routing = false;
  LatLng? _selectedStart;
  LatLng? _selectedDest;
  bool _selectingStart = true;

  Future<void> _verifyFerrostar() async {
    try {
      final location = createUserLocation(
        coordinates: await makeGeographicCoordinate(
          lat: _start.latitude,
          lng: _start.longitude,
        ),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.now(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ferrostar OK: ${_start.latitude.toStringAsFixed(4)}, ${_start.longitude.toStringAsFixed(4)}',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ferrostar error: $e')));
    }
  }

  Future<void> _routeValhalla() async {
    try {
      setState(() => _routing = true);

      final startCoord = _selectedStart ?? _start;
      final destCoord = _selectedDest ?? _dest;

      if (_selectedStart == null || _selectedDest == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tap the map to pick both start and end. Using defaults.',
            ),
          ),
        );
      }

      final userLocation = createUserLocation(
        coordinates: await makeGeographicCoordinate(
          lat: startCoord.latitude,
          lng: startCoord.longitude,
        ),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.now(),
      );

      final destination = await createWaypointWithValhallaProperties(
        coordinate: await makeGeographicCoordinate(
          lat: destCoord.latitude,
          lng: destCoord.longitude,
        ),
        kind: await waypointKindBreak(),
        properties: await defaultValhallaWaypointProperties(),
      );

      final request = await generateValhallaRequest(
        endpointUrl:
            'https://api.stadiamaps.com/route/v1?api_key=66acce60-37b4-438f-a525-7be77d0b3757',
        profile: 'auto',
        userLocation: userLocation,
        waypoints: [destination],
      );

      List<int> responseBytes;
      if (request is FerrostarRouteRequest_HttpPost) {
        responseBytes = await _sendPost(
          url: request.url,
          headers: Map.fromEntries(
            request.headers.map((e) => MapEntry(e.$1, e.$2)),
          ),
          body: request.body,
        );
      } else if (request is FerrostarRouteRequest_HttpGet) {
        responseBytes = await _sendGet(
          url: request.url,
          headers: Map.fromEntries(
            request.headers.map((e) => MapEntry(e.$1, e.$2)),
          ),
        );
      } else {
        throw Exception('Unsupported route request type');
      }

      final routes = await parseOsrmResponse(
        response: responseBytes,
        polylinePrecision: 6,
      );

      if (routes.isEmpty) {
        throw Exception('No routes returned');
      }

      final geometryCoords = await routeGeometry(route: routes.first);
      final geometry = geometryCoords
          .map((coord) => LatLng(coord.lat, coord.lng))
          .toList(growable: false);

      if (!mounted) return;
      setState(() {
        _routePoints = geometry;
        _routing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Valhalla route loaded (${geometry.length} points)'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _routing = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Valhalla routing error: $e')));
    }
  }

  Future<List<int>> _sendPost({
    required String url,
    required Map<String, String> headers,
    required List<int> body,
  }) async {
    final client = HttpClient();
    final request = await client.postUrl(Uri.parse(url));
    headers.forEach(request.headers.set);
    request.add(body);
    final response = await request.close();
    final bytes = await response.fold<List<int>>(
      <int>[],
      (prev, chunk) => prev..addAll(chunk),
    );
    client.close(force: true);
    if (response.statusCode >= 400) {
      throw HttpException('Status ${response.statusCode}', uri: Uri.parse(url));
    }
    return bytes;
  }

  Future<List<int>> _sendGet({
    required String url,
    required Map<String, String> headers,
  }) async {
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(url));
    headers.forEach(request.headers.set);
    final response = await request.close();
    final bytes = await response.fold<List<int>>(
      <int>[],
      (prev, chunk) => prev..addAll(chunk),
    );
    client.close(force: true);
    if (response.statusCode >= 400) {
      throw HttpException('Status ${response.statusCode}', uri: Uri.parse(url));
    }
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ferrostar Map')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _start,
          initialZoom: 12.0,
          onTap: (tapPos, latlng) {
            setState(() {
              if (_selectingStart) {
                _selectedStart = latlng;
              } else {
                _selectedDest = latlng;
              }
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.ferrostar.flutter_example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _selectedStart ?? _start,
                width: 40,
                height: 40,
                child: const Icon(Icons.flag, color: Colors.green, size: 30),
              ),
              Marker(
                point: _selectedDest ?? _dest,
                width: 40,
                height: 40,
                child: const Icon(Icons.place, color: Colors.red, size: 30),
              ),
            ],
          ),
          if (_routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _routePoints,
                  strokeWidth: 4,
                  color: Colors.blue,
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _verifyFerrostar,
            label: const Text('Verify Ferrostar'),
            icon: const Icon(Icons.check),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterChip(
                label: const Text('Set start'),
                selected: _selectingStart,
                onSelected: (_) => setState(() => _selectingStart = true),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Set end'),
                selected: !_selectingStart,
                onSelected: (_) => setState(() => _selectingStart = false),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: _routing ? null : _routeValhalla,
            label: Text(_routing ? 'Routing…' : 'Route selection'),
            icon: const Icon(Icons.route),
          ),
          const SizedBox(height: 8),
          if (_routePoints.isNotEmpty ||
              _selectedStart != null ||
              _selectedDest != null)
            FloatingActionButton.small(
              heroTag: 'clear',
              onPressed: () {
                setState(() {
                  _routePoints = const [];
                  _selectedStart = null;
                  _selectedDest = null;
                });
              },
              tooltip: 'Clear selection',
              child: const Icon(Icons.clear),
            ),
        ],
      ),
    );
  }
}

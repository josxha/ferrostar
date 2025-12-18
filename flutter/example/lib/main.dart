import 'dart:io';

import 'package:flutter/material.dart' hide Route;
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
  final MapController _mapController = MapController();
  RouteHandle? _activeRouteHandle;
  List<String> _stepInstructions = const [];
  List<int> _stepPointOffsets = const [];
  String? _nextInstruction;

  void _reportError(String context, Object error, StackTrace st) {
    debugPrint('$context: $error');
    debugPrintStack(stackTrace: st);
  }

  List<LatLng> _routePoints = const [];
  Route? _activeRoute;
  FlutterNavigationController? _controller;
  FlutterNavState? _navState;
  String _navStatus = 'Idle';
  int _navProgressIndex = 0;
  List<Polyline> _stepPolylines = const [];
  LatLng? _progressMarker;
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
    } catch (e, st) {
      _reportError('Ferrostar error', e, st);
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

      final pickedRoute = routes.first;

      if (_activeRouteHandle != null) {
        await releaseRoute(handle: _activeRouteHandle!);
      }

      final handle = await retainRoute(route: pickedRoute);
      final geometryCoords = await routeGeometryFromHandle(handle: handle);
      final geometry = geometryCoords
          .map((coord) => LatLng(coord.lat, coord.lng))
          .toList(growable: false);

      final simpleSteps = await routeStepsFromHandle(handle: handle);
      List<Polyline> stepPolylines = const [];
      List<String> stepInstructions = const [];
      List<int> stepPointOffsets = const [];
      if (simpleSteps.isNotEmpty) {
        const palette = [
          Colors.deepPurple,
          Colors.teal,
          Colors.orange,
          Colors.pink,
          Colors.indigo,
        ];
        stepPolylines = [
          for (var i = 0; i < simpleSteps.length; i++)
            Polyline(
              points: simpleSteps[i].geometry
                  .map((c) => LatLng(c.lat, c.lng))
                  .toList(growable: false),
              strokeWidth: 5,
              color: palette[i % palette.length].withOpacity(0.8),
            ),
        ];
        stepInstructions = [for (final s in simpleSteps) s.instruction];
        stepPointOffsets = [];
        var runningTotal = 0;
        for (final s in simpleSteps) {
          runningTotal += s.geometry.length;
          stepPointOffsets.add(runningTotal);
        }
      }
      final progressMarker = geometry.isNotEmpty ? geometry.first : null;
      final initialInstruction = _nextInstructionForIndex(
        0,
        stepInstructions,
        stepPointOffsets,
      );

      if (!mounted) return;
      setState(() {
        _routePoints = geometry;
        _activeRoute = pickedRoute;
        _activeRouteHandle = handle;
        _controller = null;
        _navState = null;
        _navStatus = 'Idle';
        _navProgressIndex = 0;
        _stepPolylines = stepPolylines;
        _progressMarker = progressMarker;
        _stepInstructions = stepInstructions;
        _stepPointOffsets = stepPointOffsets;
        _nextInstruction = initialInstruction;
        _routing = false;
      });
      _recenterOnMarker();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Valhalla route loaded (${geometry.length} points)'),
        ),
      );
    } catch (e, st) {
      _reportError('Valhalla routing error', e, st);
      if (!mounted) return;
      setState(() => _routing = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Valhalla routing error: $e')));
    }
  }

  Future<void> _startNavigation() async {
    if (_activeRouteHandle == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Route missing. Fetch a route first.')),
      );
      return;
    }

    try {
      final config = await demoNavigationConfig();
      final controller = await navigationControllerFromRouteHandle(
        handle: _activeRouteHandle!,
        config: config,
      );

      final startCoord = _selectedStart ?? _start;
      final startLoc = await createUserLocation(
        coordinates: await makeGeographicCoordinate(
          lat: startCoord.latitude,
          lng: startCoord.longitude,
        ),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.now(),
        courseOverGround: null,
        speed: null,
      );

      final state = await controller.getInitialState(location: startLoc);
      final tripState = await state.tripState();
      final status = await tripStateVariant(state: tripState);

      if (!mounted) return;
      setState(() {
        _controller = controller;
        _navState = state;
        _navStatus = status;
        _navProgressIndex = 0;
        _progressMarker = _routePoints.isNotEmpty ? _routePoints.first : null;
        _nextInstruction = _nextInstructionForIndex(
          0,
          _stepInstructions,
          _stepPointOffsets,
        );
      });
      _recenterOnMarker();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Navigation started ($status)')));
    } catch (e, st) {
      _reportError('Navigation start error', e, st);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Navigation error: $e')));
    }
  }

  Future<void> _stepNavigation() async {
    if (_controller == null || _navState == null || _routePoints.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Start navigation first.')));
      return;
    }

    final nextIndex = (_navProgressIndex + 1).clamp(0, _routePoints.length - 1);
    final coord = _routePoints[nextIndex];

    try {
      final loc = await createUserLocation(
        coordinates: await makeGeographicCoordinate(
          lat: coord.latitude,
          lng: coord.longitude,
        ),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.now(),
        courseOverGround: null,
        speed: null,
      );

      final newState = await _controller!.updateUserLocation(
        location: loc,
        state: _navState!,
      );
      final tripState = await newState.tripState();
      final status = await tripStateVariant(state: tripState);

      if (!mounted) return;
      setState(() {
        _navState = newState;
        _navStatus = status;
        _navProgressIndex = nextIndex;
        _progressMarker = coord;
        _nextInstruction = _nextInstructionForIndex(
          nextIndex,
          _stepInstructions,
          _stepPointOffsets,
        );
      });
      _recenterOnMarker();
    } catch (e, st) {
      _reportError('Navigation update error', e, st);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update error: $e')));
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

  String? _nextInstructionForIndex(
    int index,
    List<String> instructions,
    List<int> offsets,
  ) {
    if (instructions.isEmpty) return null;
    final stepIdx = _stepIndexForProgress(index, offsets);
    if (stepIdx == null) return instructions.first;
    final nextIdx = (stepIdx + 1 < instructions.length) ? stepIdx + 1 : stepIdx;
    return instructions[nextIdx];
  }

  int? _stepIndexForProgress(int index, List<int> offsets) {
    if (offsets.isEmpty) return null;
    for (var i = 0; i < offsets.length; i++) {
      if (index < offsets[i]) return i;
    }
    return offsets.length - 1;
  }

  void _recenterOnMarker() {
    final target = _progressMarker;
    if (target == null) return;
    final zoom = _mapController.camera.zoom;
    _mapController.move(target, zoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ferrostar Map')),
      body: FlutterMap(
        mapController: _mapController,
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
          if (_stepPolylines.isNotEmpty)
            PolylineLayer(polylines: _stepPolylines),
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
              if (_progressMarker != null)
                Marker(
                  point: _progressMarker!,
                  width: 26,
                  height: 26,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent.withOpacity(0.85),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
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
          FloatingActionButton.extended(
            onPressed: (_activeRoute != null && !_routing)
                ? _startNavigation
                : null,
            label: const Text('Start navigation'),
            icon: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: (_controller != null && _navState != null)
                ? _stepNavigation
                : null,
            label: const Text('Advance step'),
            icon: const Icon(Icons.directions_walk),
          ),
          const SizedBox(height: 8),
          if (_routePoints.isNotEmpty ||
              _selectedStart != null ||
              _selectedDest != null)
            FloatingActionButton.small(
              heroTag: 'clear',
              onPressed: () {
                final handle = _activeRouteHandle;
                if (handle != null) {
                  releaseRoute(handle: handle);
                }
                setState(() {
                  _routePoints = const [];
                  _activeRoute = null;
                  _activeRouteHandle = null;
                  _controller = null;
                  _navState = null;
                  _navStatus = 'Idle';
                  _navProgressIndex = 0;
                  _selectedStart = null;
                  _selectedDest = null;
                  _stepInstructions = const [];
                  _stepPointOffsets = const [];
                  _nextInstruction = null;
                  _stepPolylines = const [];
                  _progressMarker = null;
                });
              },
              tooltip: 'Clear selection',
              child: const Icon(Icons.clear),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nav: $_navStatus'),
                if (_stepInstructions.isNotEmpty)
                  Text(() {
                    final idx = _stepIndexForProgress(
                      _navProgressIndex,
                      _stepPointOffsets,
                    );
                    final display = idx != null ? idx + 1 : 0;
                    return 'Step $display/${_stepInstructions.length}';
                  }()),
              ],
            ),
            const SizedBox(height: 6),
            if (_nextInstruction != null)
              Text(
                'Next: ${_nextInstruction!}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

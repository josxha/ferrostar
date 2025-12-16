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

  Future<void> _verifyFerrostar() async {
    try {
      final location = await createUserLocation(
        coordinates: GeographicCoordinate(
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
            'Ferrostar OK: ${location.coordinates.lat.toStringAsFixed(4)}, ${location.coordinates.lng.toStringAsFixed(4)}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ferrostar Map')),
      body: FlutterMap(
        options: const MapOptions(initialCenter: _start, initialZoom: 12.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.ferrostar.flutter_example',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _verifyFerrostar,
        label: const Text('Verify Ferrostar'),
        icon: const Icon(Icons.check),
      ),
    );
  }
}

import 'package:flutter/material.dart' hide Route;
import 'package:flutter_ferrostar/flutter_ferrostar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Future<void> main() async {
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
  FlutterNavigationController? _controller;
  FlutterNavState? _navState;
  TripState? _tripState;

  // Demo route geometry
  final List<LatLng> _routePoints = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.7750, -122.4195),
    const LatLng(37.7755, -122.4200),
    const LatLng(37.7760, -122.4205),
  ];

  @override
  void initState() {
    super.initState();
    _initNavigation();
  }

  Future<void> _initNavigation() async {
    // 1. Create Route
    final route = Route(
      geometry: _routePoints
          .map((p) => GeographicCoordinate(lat: p.latitude, lng: p.longitude))
          .toList(),
      bbox: const BoundingBox(
        sw: GeographicCoordinate(lat: 37.7749, lng: -122.4205),
        ne: GeographicCoordinate(lat: 37.7760, lng: -122.4194),
      ),
      distance: 500.0,
      waypoints: [
        const Waypoint(
          coordinate: GeographicCoordinate(lat: 37.7749, lng: -122.4194),
          kind: WaypointKind.break_,
        ),
        const Waypoint(
          coordinate: GeographicCoordinate(lat: 37.7760, lng: -122.4205),
          kind: WaypointKind.break_,
        ),
      ],
      steps: [
        RouteStep(
          geometry: _routePoints
              .map(
                (p) => GeographicCoordinate(lat: p.latitude, lng: p.longitude),
              )
              .toList(),
          distance: 500.0,
          duration: 300.0,
          roadName: 'Demo St',
          instruction: 'Go straight',
          visualInstructions: [],
          spokenInstructions: [],
          exits: [],
          incidents: [],
        ),
      ],
    );

    // 2. Create Config
    final config = NavigationControllerConfig(
      waypointAdvance: const WaypointAdvanceMode.waypointWithinRange(15.0),
      stepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
      arrivalStepAdvanceCondition:
          const SerializableStepAdvanceCondition.manual(),
      routeDeviationTracking: const RouteDeviationTracking.none(),
      snappedLocationCourseFiltering: CourseFiltering.snapToRoute,
    );

    // 3. Create Controller
    _controller = await FlutterNavigationController.newInstance(
      route: route,
      config: config,
    );

    // 4. Initial State
    final initialLocation = await createUserLocation(
      coordinates: const GeographicCoordinate(lat: 37.7749, lng: -122.4194),
      horizontalAccuracy: 5.0,
      timestamp: DateTime.now(),
      courseOverGround: const CourseOverGround(degrees: 0, accuracy: 10),
      speed: const Speed(value: 0.0, accuracy: 1.0),
    );

    _navState = await _controller!.getInitialState(location: initialLocation);
    _tripState = await _navState!.tripState();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ferrostar Showcase')),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(37.7755, -122.4200),
          initialZoom: 17.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.ferrostar.flutter_example',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
          if (_tripState != null) MarkerLayer(markers: [_buildUserMarker()]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _simulateMovement,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  Marker _buildUserMarker() {
    // Extract location from trip state
    // Note: In a real app, you'd use the snapped location from the state
    // For now, we'll just use the first point or simulate movement

    // We need to access the location from the trip state.
    // Since FlutterTripState is a sealed class (union), we need to switch on it.

    GeographicCoordinate? location;

    final state = _tripState!;
    if (state is TripState_Navigating) {
      location = state.snappedUserLocation.coordinates;
    } else if (state is TripState_Idle) {
      // Idle state might have a location if we passed one, but let's assume start
      location = const GeographicCoordinate(lat: 37.7749, lng: -122.4194);
    }

    if (location == null)
      return const Marker(point: LatLng(0, 0), child: SizedBox());

    return Marker(
      point: LatLng(location.lat, location.lng),
      width: 40,
      height: 40,
      child: const Icon(Icons.navigation, color: Colors.red, size: 40),
    );
  }

  Future<void> _simulateMovement() async {
    if (_controller == null || _navState == null) return;

    // Simulate moving to the next point
    final nextLocation = await createUserLocation(
      coordinates: const GeographicCoordinate(lat: 37.7750, lng: -122.4195),
      horizontalAccuracy: 5.0,
      timestamp: DateTime.now(),
      courseOverGround: const CourseOverGround(degrees: 0, accuracy: 10),
      speed: const Speed(value: 5.0, accuracy: 1.0),
    );

    _navState = await _controller!.updateUserLocation(
      location: nextLocation,
      state: _navState!,
    );
    _tripState = await _navState!.tripState();

    if (mounted) {
      setState(() {});
    }
  }
}

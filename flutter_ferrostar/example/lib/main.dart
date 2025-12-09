import 'package:flutter/material.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ferrostar POC')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FutureBuilder<String>(
                  future: createCoordinateString(lat: 37.7749, lng: -122.4194),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        'Action: Call Rust `createCoordinateString`\nResult: `${snapshot.data}`',
                        textAlign: TextAlign.center,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 20),
                _buildConfigTest(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfigTest() {
    try {
      final config = FlutterNavigationControllerConfig(
        waypointAdvance: const WaypointAdvanceMode.waypointWithinRange(10.0),
        stepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
        arrivalStepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
        routeDeviationTracking: const FlutterRouteDeviationTracking.none(),
        snappedLocationCourseFiltering: CourseFiltering.snapToRoute,
      );
      
      final location = FlutterUserLocation(
        coordinates: const GeographicCoordinate(lat: 37.7749, lng: -122.4194),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.now(),
      );

      return Text(
        'Config created successfully:\n$config\n\nLocation created successfully:\n$location',
        textAlign: TextAlign.center,
      );
    } catch (e) {
      return Text('Error creating objects: $e');
    }
  }
}

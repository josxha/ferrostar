import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await RustLib.init();
  });

  testWidgets('Full navigation lifecycle integration test', (WidgetTester tester) async {
    // 1. Setup Route
    final route = Route(
      geometry: [
        const GeographicCoordinate(lat: 37.7749, lng: -122.4194),
        const GeographicCoordinate(lat: 37.7750, lng: -122.4195),
      ],
      bbox: const BoundingBox(
        sw: GeographicCoordinate(lat: 37.7749, lng: -122.4195),
        ne: GeographicCoordinate(lat: 37.7750, lng: -122.4194),
      ),
      distance: 100.0,
      waypoints: [
        const Waypoint(
          coordinate: GeographicCoordinate(lat: 37.7749, lng: -122.4194),
          kind: WaypointKind.break_,
        ),
        const Waypoint(
          coordinate: GeographicCoordinate(lat: 37.7750, lng: -122.4195),
          kind: WaypointKind.break_,
        ),
      ],
      steps: [
        const RouteStep(
          geometry: [
            GeographicCoordinate(lat: 37.7749, lng: -122.4194),
            GeographicCoordinate(lat: 37.7750, lng: -122.4195),
          ],
          distance: 100.0,
          duration: 60.0,
          roadName: 'Main St',
          instruction: 'Go straight',
          visualInstructions: [],
          spokenInstructions: [],
          exits: [],
          incidents: [],
        ),
      ],
    );

    // 2. Setup Config
    final config = FlutterNavigationControllerConfig(
      waypointAdvance: const WaypointAdvanceMode.waypointWithinRange(15.0),
      stepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
      arrivalStepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
      routeDeviationTracking: const FlutterRouteDeviationTracking.none(),
      snappedLocationCourseFiltering: CourseFiltering.snapToRoute,
    );

    // 3. Create Controller
    final controller = await FlutterNavigationController.newInstance(
      route: route,
      config: config,
    );

    expect(controller, isNotNull);

    // 4. Get Initial State
    final initialLocation = FlutterUserLocation(
      coordinates: const GeographicCoordinate(lat: 37.7749, lng: -122.4194),
      horizontalAccuracy: 5.0,
      timestamp: DateTime.now(),
      courseOverGround: const CourseOverGround(degrees: 0, accuracy: 10),
      speed: const Speed(value: 0.0, accuracy: 1.0),
    );

    var state = await controller.getInitialState(location: initialLocation);
    var tripState = await state.tripState();
    
    expect(tripState, isA<FlutterTripState_Navigating>());

    // 5. Update Location
    final newLocation = FlutterUserLocation(
      coordinates: const GeographicCoordinate(lat: 37.77495, lng: -122.41945),
      horizontalAccuracy: 5.0,
      timestamp: DateTime.now(),
      courseOverGround: const CourseOverGround(degrees: 0, accuracy: 10),
      speed: const Speed(value: 5.0, accuracy: 1.0),
    );

    state = await controller.updateUserLocation(
      location: newLocation,
      state: state,
    );
    
    tripState = await state.tripState();
    expect(tripState, isA<FlutterTripState_Navigating>());
  });
}

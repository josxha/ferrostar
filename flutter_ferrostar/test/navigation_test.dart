import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';
import 'package:flutter_ferrostar/src/rust/frb_generated.dart';

class MockRustLibApi extends Mock implements RustLibApi {}

class MockFlutterNavigationController extends Mock
    implements FlutterNavigationController {}

class MockFlutterNavState extends Mock implements FlutterNavState {}

// Fake classes for fallback
class FakeRoute extends Fake implements Route {}

class FakeNavigationControllerConfig extends Fake
    implements NavigationControllerConfig {}

class FakeUserLocation extends Fake implements UserLocation {}

class FakeFlutterNavState extends Fake implements FlutterNavState {}

class FakeFlutterNavigationController extends Fake
    implements FlutterNavigationController {}

void main() {
  final mockApi = MockRustLibApi();

  setUpAll(() {
    registerFallbackValue(FakeRoute());
    registerFallbackValue(FakeNavigationControllerConfig());
    registerFallbackValue(FakeUserLocation());
    registerFallbackValue(FakeFlutterNavState());
    registerFallbackValue(FakeFlutterNavigationController());

    RustLib.initMock(api: mockApi);
  });

  setUp(() {
    reset(mockApi);

    // Stub the ARC functions to prevent crashes if they are accessed
    when(
      () => mockApi.rust_arc_increment_strong_count_FlutterNavState,
    ).thenReturn((ptr) {});
    when(
      () => mockApi.rust_arc_decrement_strong_count_FlutterNavState,
    ).thenReturn((ptr) {});
    when(
      () => mockApi.rust_arc_increment_strong_count_FlutterNavigationController,
    ).thenReturn((ptr) {});
    when(
      () => mockApi.rust_arc_decrement_strong_count_FlutterNavigationController,
    ).thenReturn((ptr) {});
  });

  group('FlutterNavigationController', () {
    test('newInstance returns controller', () async {
      final route = Route(
        geometry: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
        distance: 100,
        steps: const [],
        waypoints: const [],
      );
      final config = NavigationControllerConfig(
        waypointAdvance: const WaypointAdvanceMode.waypointWithinRange(15.0),
        stepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
        arrivalStepAdvanceCondition:
            const SerializableStepAdvanceCondition.manual(),
        routeDeviationTracking: const RouteDeviationTracking.none(),
        snappedLocationCourseFiltering: CourseFiltering.snapToRoute,
      );

      final mockController = MockFlutterNavigationController();
      when(
        () => mockApi.crateApiNavigationFlutterNavigationControllerNew(
          route: any(named: 'route'),
          config: any(named: 'config'),
        ),
      ).thenAnswer((_) async => mockController);

      final controller = await FlutterNavigationController.newInstance(
        route: route,
        config: config,
      );
      expect(controller, equals(mockController));

      verify(
        () => mockApi.crateApiNavigationFlutterNavigationControllerNew(
          route: route,
          config: config,
        ),
      ).called(1);
    });

    test('methods call mock implementation', () async {
      final controller = MockFlutterNavigationController();
      final location = await createUserLocation(
        coordinates: const GeographicCoordinate(lat: 0, lng: 0),
        horizontalAccuracy: 0,
        timestamp: DateTime.now(),
        courseOverGround: const CourseOverGround(degrees: 0),
        speed: const Speed(value: 0, accuracy: 0),
      );
      final mockState = MockFlutterNavState();

      when(
        () => controller.getInitialState(location: any(named: 'location')),
      ).thenAnswer((_) async => mockState);
      when(
        () => controller.advanceToNextStep(state: any(named: 'state')),
      ).thenAnswer((_) async => mockState);

      final state = await controller.getInitialState(location: location);
      expect(state, equals(mockState));

      final nextState = await controller.advanceToNextStep(state: state);
      expect(nextState, equals(mockState));
    });
  });

  group('FlutterNavState', () {
    test('tripState returns idle', () async {
      final state = MockFlutterNavState();
      when(
        () => state.tripState(),
      ).thenAnswer((_) async => const TripState.idle());

      final tripState = await state.tripState();
      expect(tripState, isA<TripState_Idle>());
    });
  });
}

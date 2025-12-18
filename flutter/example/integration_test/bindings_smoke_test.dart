import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await RustLib.init();
  });

  Future<void> expectNavigating(FlutterNavState state) async {
    final tripState = await state.tripState();
    expect(await tripStateVariant(state: tripState), equals('Navigating'));
  }

  const origin = SimpleGeographicCoordinate(lat: 0.0, lng: 0.0);
  const dest = SimpleGeographicCoordinate(lat: 0.0001, lng: 0.0001);

  group('coordinates & locations', () {
    testWidgets('construct and echo coordinates', (tester) async {
      final coord = await makeGeographicCoordinate(lat: 1.0, lng: 2.0);
      final echoed = await passthroughCoordinate(coord: coord);
      final parts = await geographicCoordinateComponents(coord: echoed);
      expect(parts.lat, equals(1.0));
      expect(parts.lng, equals(2.0));
    });

    testWidgets('user location helpers expose snapshot', (tester) async {
      final coord = await makeGeographicCoordinate(lat: 0.5, lng: -0.25);
      final userLocation = await createUserLocation(
        coordinates: coord,
        horizontalAccuracy: 3.0,
        courseOverGround: null,
        timestamp: DateTime.now(),
        speed: null,
      );

      final snapshot = await describeUserLocation(location: userLocation);
      expect(snapshot.coordinates.lat, closeTo(0.5, 1e-9));
      expect(snapshot.horizontalAccuracy, closeTo(3.0, 1e-9));
    });
  });

  group('simulation', () {
    testWidgets('advances along provided lat/lng points', (tester) async {
      final sim = await locationSimulationFromLatLng(
        coordinates: const [origin, dest],
        bias: const LocationBias.none(),
      );

      final initial = await describeUserLocation(
        location: await sim.currentLocation(),
      );
      expect(initial.coordinates.lat, closeTo(0.0, 1e-6));

      final advanced = await advanceLocationSimulation(state: sim);
      final next = await describeUserLocation(
        location: await advanced.currentLocation(),
      );
      expect(next.coordinates.lat, closeTo(0.0001, 1e-6));
      expect(next.coordinates.lng, closeTo(0.0001, 1e-6));
    });

    testWidgets('simulation can be built from demo route', (tester) async {
      final sim = await locationSimulationFromDemoRoute(
        resampleDistance: null,
        bias: const LocationBias.none(),
      );

      final next = await describeUserLocation(
        location: await sim.currentLocation(),
      );

      expect(next.coordinates.lat, closeTo(37.7749, 1e-4));
    });

    testWidgets('locationSimulationFromCoordinates advances positions', (
      tester,
    ) async {
      final a = await makeGeographicCoordinate(lat: 0.0, lng: 0.0);
      final b = await makeGeographicCoordinate(lat: 0.0001, lng: 0.0001);

      final sim = await locationSimulationFromCoordinates(
        coordinates: [a, b],
        bias: const LocationBias.none(),
      );

      final initial = await describeUserLocation(
        location: await sim.currentLocation(),
      );
      expect(initial.horizontalAccuracy, closeTo(0.0, 1e-6));

      final advanced = await advanceLocationSimulation(state: sim);
      final next = await describeUserLocation(
        location: await advanced.currentLocation(),
      );

      expect(next.coordinates.lat, closeTo(0.0001, 1e-6));
      expect(next.coordinates.lng, closeTo(0.0001, 1e-6));
    });
  });

  group('routing', () {
    testWidgets('Valhalla request generation produces headers', (tester) async {
      final request = await generateValhallaRequestSimple(
        endpointUrl: 'https://example.com/valhalla',
        profile: 'auto',
        userLocation: origin,
        waypoints: const [
          origin,
          SimpleGeographicCoordinate(lat: 0.001, lng: 0.001),
        ],
      );

      request.when(
        httpGet: (url, headers) {
          expect(url, contains('example.com/valhalla'));
          expect(headers, isNotEmpty);
        },
        httpPost: (url, headers, body) {
          expect(url, contains('example.com/valhalla'));
          expect(headers, isNotEmpty);
          expect(body, isNotEmpty);
        },
      );
    });

    testWidgets('route geometry helper returns coordinates', (tester) async {
      final route = await demoRoute();
      final simple = await routeGeometry(route: route);
      expect(simple, isNotEmpty);
    });
  });

  group('navigation controller', () {
    testWidgets('demo controller yields navigating state', (tester) async {
      final controller = await demoNavigationController();
      final initial = await demoUserLocationStart();
      var state = await controller.getInitialState(location: initial);
      await expectNavigating(state);

      final updated = await demoUserLocationNext();
      state = await controller.updateUserLocation(
        location: updated,
        state: state,
      );
      await expectNavigating(state);
    });
  });
}

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';

import 'shared.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const startLat = 47.6603;
  const startLng = 9.1758;
  const destLat = 47.6735;
  const destLng = 9.1719;
  RouteHandle? retainedHandle;

  setUpAll(() async {
    await ensureRustInitialized();
  });

  tearDownAll(() async {
    if (retainedHandle != null) {
      await releaseRoute(handle: retainedHandle!);
    }
  });

  Future<List<int>> _fetchRoute(FerrostarRouteRequest request) async {
    final client = HttpClient();
    try {
      if (request is FerrostarRouteRequest_HttpGet) {
        final req = await client.getUrl(Uri.parse(request.url));
        request.headers.forEach((h) => req.headers.add(h.$1, h.$2));
        final resp = await req.close();
        final bytes = await resp.fold<List<int>>(
          <int>[],
          (p, c) => p..addAll(c),
        );
        if (resp.statusCode >= 400) {
          throw HttpException(
            'Status ${resp.statusCode}',
            uri: Uri.parse(request.url),
          );
        }
        return bytes;
      }
      if (request is FerrostarRouteRequest_HttpPost) {
        final req = await client.postUrl(Uri.parse(request.url));
        request.headers.forEach((h) => req.headers.add(h.$1, h.$2));
        req.add(request.body);
        final resp = await req.close();
        final bytes = await resp.fold<List<int>>(
          <int>[],
          (p, c) => p..addAll(c),
        );
        if (resp.statusCode >= 400) {
          throw HttpException(
            'Status ${resp.statusCode}',
            uri: Uri.parse(request.url),
          );
        }
        return bytes;
      }
      throw Exception('Unsupported route request type: ${request.runtimeType}');
    } finally {
      client.close(force: true);
    }
  }

  testWidgets('Valhalla live route supports navigation start', (tester) async {
    final requestLocation = createUserLocation(
      coordinates: await makeGeographicCoordinate(lat: startLat, lng: startLng),
      horizontalAccuracy: 5.0,
      timestamp: DateTime.now(),
    );

    final destination = await createWaypointWithValhallaProperties(
      coordinate: await makeGeographicCoordinate(lat: destLat, lng: destLng),
      kind: await waypointKindBreak(),
      properties: await defaultValhallaWaypointProperties(),
    );

    final request = await generateValhallaRequest(
      endpointUrl:
          'https://api.stadiamaps.com/route/v1?api_key=66acce60-37b4-438f-a525-7be77d0b3757',
      profile: 'auto',
      userLocation: requestLocation,
      waypoints: [destination],
    );

    final response = await _fetchRoute(request);
    final routes = await parseOsrmResponse(
      response: response,
      polylinePrecision: 6,
    );
    expect(routes, isNotEmpty);

    final route = routes.first;
    retainedHandle = await retainRoute(route: route);
    final geometry = await routeGeometryFromHandle(handle: retainedHandle!);
    expect(geometry, isNotEmpty);

    final config = await demoNavigationConfig();
    final navStartLocation = await createUserLocation(
      coordinates: await makeGeographicCoordinate(lat: startLat, lng: startLng),
      horizontalAccuracy: 5.0,
      timestamp: DateTime.now(),
      courseOverGround: null,
      speed: null,
    );
    final controller = await navigationControllerFromRouteHandle(
      handle: retainedHandle!,
      config: config,
    );

    final state = await controller.getInitialState(location: navStartLocation);
    final tripState = await state.tripState();
    expect(await tripStateVariant(state: tripState), equals('Navigating'));

    // Advance one step along the geometry to ensure updates succeed.
    if (geometry.length > 1) {
      final next = geometry[1];
      final nextLoc = await createUserLocation(
        coordinates: await makeGeographicCoordinate(
          lat: next.lat,
          lng: next.lng,
        ),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.now(),
        courseOverGround: null,
        speed: null,
      );
      final updated = await controller.updateUserLocation(
        location: nextLoc,
        state: state,
      );
      final nextTripState = await updated.tripState();
      expect(
        await tripStateVariant(state: nextTripState),
        equals('Navigating'),
      );
    }
  });
}

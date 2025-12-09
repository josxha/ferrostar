import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';

void main() {
  test('FlutterNavigationControllerConfig instantiation', () {
    final config = FlutterNavigationControllerConfig(
      waypointAdvance: const WaypointAdvanceMode.waypointWithinRange(15.0),
      stepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
      arrivalStepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
      routeDeviationTracking: const FlutterRouteDeviationTracking.none(),
      snappedLocationCourseFiltering: CourseFiltering.snapToRoute,
    );

    expect(config.waypointAdvance, isA<WaypointAdvanceMode_WaypointWithinRange>());
    if (config.waypointAdvance case WaypointAdvanceMode_WaypointWithinRange(field0: final distance)) {
      expect(distance, 15.0);
    }
    
    expect(config.stepAdvanceCondition, const SerializableStepAdvanceCondition.manual());
    expect(config.routeDeviationTracking, const FlutterRouteDeviationTracking.none());
    expect(config.snappedLocationCourseFiltering, CourseFiltering.snapToRoute);
  });

  test('GeographicCoordinate instantiation', () {
    const coord = GeographicCoordinate(lat: 37.7749, lng: -122.4194);
    expect(coord.lat, 37.7749);
    expect(coord.lng, -122.4194);
  });
}

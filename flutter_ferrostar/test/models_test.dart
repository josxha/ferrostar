import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Models Tests', () {
    test('BoundingBox', () {
      const bbox = BoundingBox(sw: GeographicCoordinate(lat: 0, lng: 0), ne: GeographicCoordinate(lat: 10, lng: 10));
      expect(bbox.toString(), 'BoundingBox(sw: GeographicCoordinate(lat: 0.0, lng: 0.0), ne: GeographicCoordinate(lat: 10.0, lng: 10.0))');
    });

    test('Congestion', () {
      const congestion = Congestion(value: 2);
      expect(congestion.toString(), 'Congestion(value: 2)');
    });

    test('CourseOverGround', () {
      const course = CourseOverGround(degrees: 180, accuracy: 10);
      expect(course.toString(), 'CourseOverGround(degrees: 180, accuracy: 10)');
    });

    test('FlutterNavigationControllerConfig', () {
      final config = FlutterNavigationControllerConfig(
        waypointAdvance: const WaypointAdvanceMode.waypointWithinRange(15.0),
        stepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
        arrivalStepAdvanceCondition: const SerializableStepAdvanceCondition.manual(),
        routeDeviationTracking: const FlutterRouteDeviationTracking.none(),
        snappedLocationCourseFiltering: CourseFiltering.snapToRoute,
      );
      expect(config.toString(), contains('FlutterNavigationControllerConfig'));
    });

    test('FlutterUserLocation', () {
      final location = FlutterUserLocation(
        coordinates: const GeographicCoordinate(lat: 37.7749, lng: -122.4194),
        horizontalAccuracy: 5.0,
        timestamp: DateTime.utc(2023, 10, 26, 12, 0, 0),
        courseOverGround: const CourseOverGround(degrees: 90, accuracy: 2),
        speed: const Speed(value: 10, accuracy: 1),
      );
      expect(location.toString(), contains('FlutterUserLocation'));
    });

    test('GeographicCoordinate', () {
      const coord = GeographicCoordinate(lat: 37.7749, lng: -122.4194);
      expect(coord.toString(), 'GeographicCoordinate(lat: 37.7749, lng: -122.4194)');
    });

    test('Incident', () {
      final incident = Incident(
        id: '1',
        incidentType: IncidentType.accident,
        description: 'Accident',
        longDescription: 'Bad accident',
        creationTime: DateTime.utc(2023, 10, 26, 12, 0, 0),
        startTime: DateTime.utc(2023, 10, 26, 12, 0, 0),
        endTime: DateTime.utc(2023, 10, 26, 13, 0, 0),
        impact: null,
        lanesBlocked: [],
        congestion: null,
        closed: true,
        geometryIndexStart: BigInt.from(0),
        geometryIndexEnd: BigInt.from(1),
        subType: null,
        subTypeDescription: null,
        iso31661Alpha2: 'US',
        iso31661Alpha3: 'USA',
        affectedRoadNames: [],
        bbox: const BoundingBox(sw: GeographicCoordinate(lat: 0, lng: 0), ne: GeographicCoordinate(lat: 10, lng: 10)),
      );
      expect(incident.toString(), contains('Incident'));
    });

    test('LaneInfo', () {
      const lane = LaneInfo(active: true, directions: ['straight'], activeDirection: 'straight');
      expect(lane.toString(), "LaneInfo(active: true, directions: [straight], activeDirection: straight)");
    });

    test('Route', () {
      final route = Route(
        geometry: [],
        bbox: const BoundingBox(sw: GeographicCoordinate(lat: 0, lng: 0), ne: GeographicCoordinate(lat: 10, lng: 10)),
        distance: 1000,
        steps: [],
        waypoints: [],
      );
      expect(route.toString(), contains('Route'));
    });

    test('RouteStep', () {
      final step = RouteStep(
        geometry: [],
        distance: 100,
        duration: 60,
        roadName: 'Main St',
        instruction: 'Turn right',
        visualInstructions: [],
        spokenInstructions: [],
        exits: [],
        incidents: [],
      );
      expect(step.toString(), contains('RouteStep'));
    });

    test('Speed', () {
      const speed = Speed(value: 25, accuracy: 1);
      expect(speed.toString(), 'Speed(value: 25.0, accuracy: 1.0)');
    });

    test('SpokenInstruction', () {
      final instruction = SpokenInstruction(text: 'Turn right', ssml: null, triggerDistanceBeforeManeuver: 50, utteranceId: UuidValue.fromString('11111111-1111-1111-1111-111111111111'));
      expect(instruction.toString(), contains('SpokenInstruction'));
    });

    test('TripProgress', () {
      const progress = TripProgress(distanceToNextManeuver: 100, distanceRemaining: 500, durationRemaining: 300);
      expect(progress.toString(), 'TripProgress(distanceToNextManeuver: 100.0, distanceRemaining: 500.0, durationRemaining: 300.0)');
    });

    test('TripSummary', () {
      final summary = TripSummary(
        distanceTraveled: 1000,
        snappedDistanceTraveled: 950,
        startedAt: DateTime.utc(2023, 10, 26, 12, 0, 0),
        endedAt: DateTime.utc(2023, 10, 26, 12, 10, 0),
      );
      expect(summary.toString(), contains('TripSummary'));
    });

    test('VisualInstruction', () {
      const content = VisualInstructionContent(text: 'Turn right', exitNumbers: []);
      const instruction = VisualInstruction(
        primaryContent: content,
        triggerDistanceBeforeManeuver: 50,
      );
      expect(instruction.toString(), contains('VisualInstruction'));
    });

    test('VisualInstructionContent', () {
      const content = VisualInstructionContent(text: 'Turn right', exitNumbers: ['10A']);
      expect(content.toString(), contains('VisualInstructionContent'));
    });

    test('Waypoint', () {
      const waypoint = Waypoint(coordinate: GeographicCoordinate(lat: 0, lng: 0), kind: WaypointKind.break_);
      expect(waypoint.toString(), 'Waypoint(coordinate: GeographicCoordinate(lat: 0.0, lng: 0.0), kind: WaypointKind.break_)');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ferrostar/flutter_ferrostar.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Models Value Semantics', () {
    test('BoundingBox equality', () {
      const sw = GeographicCoordinate(lat: 0, lng: 0);
      const ne = GeographicCoordinate(lat: 10, lng: 10);
      const bbox1 = BoundingBox(sw: sw, ne: ne);
      const bbox2 = BoundingBox(sw: sw, ne: ne);
      const bbox3 = BoundingBox(
        sw: sw,
        ne: GeographicCoordinate(lat: 20, lng: 20),
      );

      expect(bbox1, equals(bbox2));
      expect(bbox1.hashCode, equals(bbox2.hashCode));
      expect(bbox1, isNot(equals(bbox3)));
    });

    test('Congestion equality', () {
      const c1 = Congestion(value: 1);
      const c2 = Congestion(value: 1);
      const c3 = Congestion(value: 2);

      expect(c1, equals(c2));
      expect(c1.hashCode, equals(c2.hashCode));
      expect(c1, isNot(equals(c3)));
    });

    test('CourseOverGround equality', () {
      const c1 = CourseOverGround(degrees: 180, accuracy: 10);
      const c2 = CourseOverGround(degrees: 180, accuracy: 10);
      const c3 = CourseOverGround(degrees: 90, accuracy: 10);

      expect(c1, equals(c2));
      expect(c1.hashCode, equals(c2.hashCode));
      expect(c1, isNot(equals(c3)));
    });

    test('GeographicCoordinate equality', () {
      const g1 = GeographicCoordinate(lat: 10, lng: 10);
      const g2 = GeographicCoordinate(lat: 10, lng: 10);
      const g3 = GeographicCoordinate(lat: 20, lng: 20);

      expect(g1, equals(g2));
      expect(g1.hashCode, equals(g2.hashCode));
      expect(g1, isNot(equals(g3)));
    });

    test('Incident equality', () {
      final i1 = Incident(
        id: '1',
        incidentType: IncidentType.accident,
        description: 'desc',
        longDescription: 'long desc',
        creationTime: DateTime.utc(2023, 1, 1),
        startTime: DateTime.utc(2023, 1, 1),
        endTime: DateTime.utc(2023, 1, 2),
        impact: null,
        lanesBlocked: const [],
        congestion: null,
        closed: true,
        geometryIndexStart: BigInt.from(0),
        geometryIndexEnd: BigInt.from(1),
        subType: null,
        subTypeDescription: null,
        iso31661Alpha2: 'US',
        iso31661Alpha3: 'USA',
        affectedRoadNames: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
      );
      final i2 = Incident(
        id: '1',
        incidentType: IncidentType.accident,
        description: 'desc',
        longDescription: 'long desc',
        creationTime: DateTime.utc(2023, 1, 1),
        startTime: DateTime.utc(2023, 1, 1),
        endTime: DateTime.utc(2023, 1, 2),
        impact: null,
        lanesBlocked: const [],
        congestion: null,
        closed: true,
        geometryIndexStart: BigInt.from(0),
        geometryIndexEnd: BigInt.from(1),
        subType: null,
        subTypeDescription: null,
        iso31661Alpha2: 'US',
        iso31661Alpha3: 'USA',
        affectedRoadNames: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
      );
      final i3 = Incident(
        id: '2',
        incidentType: IncidentType.accident,
        description: 'desc',
        longDescription: 'long desc',
        creationTime: DateTime.utc(2023, 1, 1),
        startTime: DateTime.utc(2023, 1, 1),
        endTime: DateTime.utc(2023, 1, 2),
        impact: null,
        lanesBlocked: const [],
        congestion: null,
        closed: true,
        geometryIndexStart: BigInt.from(0),
        geometryIndexEnd: BigInt.from(1),
        subType: null,
        subTypeDescription: null,
        iso31661Alpha2: 'US',
        iso31661Alpha3: 'USA',
        affectedRoadNames: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
      );

      expect(i1, equals(i2));
      expect(i1.hashCode, equals(i2.hashCode));
      expect(i1, isNot(equals(i3)));
    });

    test('LaneInfo equality', () {
      const l1 = LaneInfo(
        active: true,
        directions: ['straight'],
        activeDirection: 'straight',
      );
      const l2 = LaneInfo(
        active: true,
        directions: ['straight'],
        activeDirection: 'straight',
      );
      const l3 = LaneInfo(
        active: false,
        directions: ['straight'],
        activeDirection: 'straight',
      );

      expect(l1, equals(l2));
      expect(l1.hashCode, equals(l2.hashCode));
      expect(l1, isNot(equals(l3)));
    });

    test('Route equality', () {
      final r1 = Route(
        geometry: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
        distance: 100,
        steps: const [],
        waypoints: const [],
      );
      final r2 = Route(
        geometry: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
        distance: 100,
        steps: const [],
        waypoints: const [],
      );
      final r3 = Route(
        geometry: const [],
        bbox: const BoundingBox(
          sw: GeographicCoordinate(lat: 0, lng: 0),
          ne: GeographicCoordinate(lat: 10, lng: 10),
        ),
        distance: 200,
        steps: const [],
        waypoints: const [],
      );

      expect(r1, equals(r2));
      expect(r1.hashCode, equals(r2.hashCode));
      expect(r1, isNot(equals(r3)));
    });

    test('RouteStep equality', () {
      final s1 = RouteStep(
        geometry: const [],
        distance: 100,
        duration: 60,
        roadName: 'Main St',
        instruction: 'Turn right',
        visualInstructions: const [],
        spokenInstructions: const [],
        exits: const [],
        incidents: const [],
      );
      final s2 = RouteStep(
        geometry: const [],
        distance: 100,
        duration: 60,
        roadName: 'Main St',
        instruction: 'Turn right',
        visualInstructions: const [],
        spokenInstructions: const [],
        exits: const [],
        incidents: const [],
      );
      final s3 = RouteStep(
        geometry: const [],
        distance: 200,
        duration: 60,
        roadName: 'Main St',
        instruction: 'Turn right',
        visualInstructions: const [],
        spokenInstructions: const [],
        exits: const [],
        incidents: const [],
      );

      expect(s1, equals(s2));
      expect(s1.hashCode, equals(s2.hashCode));
      expect(s1, isNot(equals(s3)));
    });

    test('Speed equality', () {
      const s1 = Speed(value: 10, accuracy: 1);
      const s2 = Speed(value: 10, accuracy: 1);
      const s3 = Speed(value: 20, accuracy: 1);

      expect(s1, equals(s2));
      expect(s1.hashCode, equals(s2.hashCode));
      expect(s1, isNot(equals(s3)));
    });

    test('SpokenInstruction equality', () {
      final uuid = UuidValue.fromString('11111111-1111-1111-1111-111111111111');
      final s1 = SpokenInstruction(
        text: 'Turn right',
        ssml: null,
        triggerDistanceBeforeManeuver: 50,
        utteranceId: uuid,
      );
      final s2 = SpokenInstruction(
        text: 'Turn right',
        ssml: null,
        triggerDistanceBeforeManeuver: 50,
        utteranceId: uuid,
      );
      final s3 = SpokenInstruction(
        text: 'Turn left',
        ssml: null,
        triggerDistanceBeforeManeuver: 50,
        utteranceId: uuid,
      );

      expect(s1, equals(s2));
      expect(s1.hashCode, equals(s2.hashCode));
      expect(s1, isNot(equals(s3)));
    });

    test('TripProgress equality', () {
      const t1 = TripProgress(
        distanceToNextManeuver: 100,
        distanceRemaining: 500,
        durationRemaining: 300,
      );
      const t2 = TripProgress(
        distanceToNextManeuver: 100,
        distanceRemaining: 500,
        durationRemaining: 300,
      );
      const t3 = TripProgress(
        distanceToNextManeuver: 200,
        distanceRemaining: 500,
        durationRemaining: 300,
      );

      expect(t1, equals(t2));
      expect(t1.hashCode, equals(t2.hashCode));
      expect(t1, isNot(equals(t3)));
    });

    test('TripSummary equality', () {
      final t1 = TripSummary(
        distanceTraveled: 1000,
        snappedDistanceTraveled: 950,
        startedAt: DateTime.utc(2023, 1, 1),
        endedAt: DateTime.utc(2023, 1, 2),
      );
      final t2 = TripSummary(
        distanceTraveled: 1000,
        snappedDistanceTraveled: 950,
        startedAt: DateTime.utc(2023, 1, 1),
        endedAt: DateTime.utc(2023, 1, 2),
      );
      final t3 = TripSummary(
        distanceTraveled: 2000,
        snappedDistanceTraveled: 950,
        startedAt: DateTime.utc(2023, 1, 1),
        endedAt: DateTime.utc(2023, 1, 2),
      );

      expect(t1, equals(t2));
      expect(t1.hashCode, equals(t2.hashCode));
      expect(t1, isNot(equals(t3)));
    });

    test('VisualInstruction equality', () {
      const c1 = VisualInstructionContent(
        text: 'Turn right',
        exitNumbers: const [],
      );
      const v1 = VisualInstruction(
        primaryContent: c1,
        triggerDistanceBeforeManeuver: 50,
      );
      const v2 = VisualInstruction(
        primaryContent: c1,
        triggerDistanceBeforeManeuver: 50,
      );
      const v3 = VisualInstruction(
        primaryContent: c1,
        triggerDistanceBeforeManeuver: 100,
      );

      expect(v1, equals(v2));
      expect(v1.hashCode, equals(v2.hashCode));
      expect(v1, isNot(equals(v3)));
    });

    test('VisualInstructionContent equality', () {
      const v1 = VisualInstructionContent(
        text: 'Turn right',
        exitNumbers: const ['10A'],
      );
      const v2 = VisualInstructionContent(
        text: 'Turn right',
        exitNumbers: const ['10A'],
      );
      const v3 = VisualInstructionContent(
        text: 'Turn left',
        exitNumbers: const ['10A'],
      );

      expect(v1, equals(v2));
      expect(v1.hashCode, equals(v2.hashCode));
      expect(v1, isNot(equals(v3)));
    });

    test('Waypoint equality', () {
      const w1 = Waypoint(
        coordinate: GeographicCoordinate(lat: 0, lng: 0),
        kind: WaypointKind.break_,
      );
      const w2 = Waypoint(
        coordinate: GeographicCoordinate(lat: 0, lng: 0),
        kind: WaypointKind.break_,
      );
      const w3 = Waypoint(
        coordinate: GeographicCoordinate(lat: 10, lng: 10),
        kind: WaypointKind.break_,
      );

      expect(w1, equals(w2));
      expect(w1.hashCode, equals(w2.hashCode));
      expect(w1, isNot(equals(w3)));
    });
  });
}

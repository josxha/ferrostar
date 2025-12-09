pub use ferrostar::models::{
    BoundingBox, Congestion, GeographicCoordinate, Impact, Incident, IncidentType, LaneInfo,
    ManeuverModifier, ManeuverType, Route, RouteStep, SpokenInstruction, VisualInstruction,
    VisualInstructionContent, Waypoint, WaypointKind, BlockedLane, Speed, CourseOverGround,
    UserLocation
};
pub use ferrostar::navigation_controller::models::{
    TripProgress, TripState, TripSummary, CourseFiltering, WaypointAdvanceMode,
};
pub use ferrostar::deviation_detection::RouteDeviation;
pub use ferrostar::navigation_controller::step_advance::SerializableStepAdvanceCondition;
use chrono::{DateTime, Utc};
use uuid::Uuid;

#[flutter_rust_bridge::frb(mirror(GeographicCoordinate))]
pub struct _GeographicCoordinate {
    pub lat: f64,
    pub lng: f64,
}

#[flutter_rust_bridge::frb(mirror(Waypoint))]
pub struct _Waypoint {
    pub coordinate: GeographicCoordinate,
    pub kind: WaypointKind,
}

#[flutter_rust_bridge::frb(mirror(WaypointKind))]
pub enum _WaypointKind {
    Break,
    Via,
}

#[flutter_rust_bridge::frb(mirror(BoundingBox))]
pub struct _BoundingBox {
    pub sw: GeographicCoordinate,
    pub ne: GeographicCoordinate,
}

#[flutter_rust_bridge::frb(mirror(Route))]
pub struct _Route {
    pub geometry: Vec<GeographicCoordinate>,
    pub bbox: BoundingBox,
    pub distance: f64,
    pub waypoints: Vec<Waypoint>,
    pub steps: Vec<RouteStep>,
}

#[flutter_rust_bridge::frb(mirror(RouteStep))]
pub struct _RouteStep {
    pub geometry: Vec<GeographicCoordinate>,
    pub distance: f64,
    pub duration: f64,
    pub road_name: Option<String>,
    pub exits: Vec<String>,
    pub instruction: String,
    pub visual_instructions: Vec<VisualInstruction>,
    pub spoken_instructions: Vec<SpokenInstruction>,
    pub annotations: Option<Vec<String>>,
    pub incidents: Vec<Incident>,
}

#[flutter_rust_bridge::frb(mirror(VisualInstruction))]
pub struct _VisualInstruction {
    pub primary_content: VisualInstructionContent,
    pub secondary_content: Option<VisualInstructionContent>,
    pub sub_content: Option<VisualInstructionContent>,
    pub trigger_distance_before_maneuver: f64,
}

#[flutter_rust_bridge::frb(mirror(VisualInstructionContent))]
pub struct _VisualInstructionContent {
    pub text: String,
    pub maneuver_type: Option<ManeuverType>,
    pub maneuver_modifier: Option<ManeuverModifier>,
    pub roundabout_exit_degrees: Option<u16>,
    pub lane_info: Option<Vec<LaneInfo>>,
    pub exit_numbers: Vec<String>,
}

#[flutter_rust_bridge::frb(mirror(LaneInfo))]
pub struct _LaneInfo {
    pub active: bool,
    pub directions: Vec<String>,
    pub active_direction: Option<String>,
}

#[flutter_rust_bridge::frb(mirror(ManeuverType))]
pub enum _ManeuverType {
    Turn,
    NewName,
    Depart,
    Arrive,
    Merge,
    OnRamp,
    OffRamp,
    Fork,
    EndOfRoad,
    Continue,
    Roundabout,
    Rotary,
    RoundaboutTurn,
    Notification,
    ExitRoundabout,
    ExitRotary,
}

#[flutter_rust_bridge::frb(mirror(ManeuverModifier))]
pub enum _ManeuverModifier {
    UTurn,
    SharpRight,
    Right,
    SlightRight,
    Straight,
    SlightLeft,
    Left,
    SharpLeft,
}

#[flutter_rust_bridge::frb(mirror(SpokenInstruction))]
pub struct _SpokenInstruction {
    pub text: String,
    pub ssml: Option<String>,
    pub trigger_distance_before_maneuver: f64,
    pub utterance_id: Uuid,
}

#[flutter_rust_bridge::frb(mirror(Incident))]
pub struct _Incident {
    pub id: String,
    pub incident_type: IncidentType,
    pub description: Option<String>,
    pub long_description: Option<String>,
    pub creation_time: Option<DateTime<Utc>>,
    pub start_time: Option<DateTime<Utc>>,
    pub end_time: Option<DateTime<Utc>>,
    pub impact: Option<Impact>,
    pub lanes_blocked: Vec<BlockedLane>,
    pub congestion: Option<Congestion>,
    pub closed: Option<bool>,
    pub geometry_index_start: u64,
    pub geometry_index_end: Option<u64>,
    pub sub_type: Option<String>,
    pub sub_type_description: Option<String>,
    pub iso_3166_1_alpha2: Option<String>,
    pub iso_3166_1_alpha3: Option<String>,
    pub affected_road_names: Vec<String>,
    pub bbox: Option<BoundingBox>,
}

#[flutter_rust_bridge::frb(mirror(IncidentType))]
pub enum _IncidentType {
    Accident,
    Congestion,
    Construction,
    DisabledVehicle,
    LaneRestriction,
    MassTransit,
    Miscellaneous,
    OtherNews,
    PlannedEvent,
    RoadClosure,
    RoadHazard,
    Weather,
}

#[flutter_rust_bridge::frb(mirror(Impact))]
pub enum _Impact {
    Unknown,
    Critical,
    Major,
    Minor,
    Low,
}

#[flutter_rust_bridge::frb(mirror(BlockedLane))]
pub enum _BlockedLane {
    Left,
    LeftCenter,
    LeftTurnLane,
    Center,
    Right,
    RightCenter,
    RightTurnLane,
    HOV,
}

#[flutter_rust_bridge::frb(mirror(Congestion))]
pub struct _Congestion {
    pub value: u8,
}

#[flutter_rust_bridge::frb(mirror(Speed))]
pub struct _Speed {
    pub value: f64,
    pub accuracy: Option<f64>,
}

#[flutter_rust_bridge::frb(mirror(CourseOverGround))]
pub struct _CourseOverGround {
    pub degrees: u16,
    pub accuracy: Option<u16>,
}

#[flutter_rust_bridge::frb(mirror(TripProgress))]
pub struct _TripProgress {
    pub distance_to_next_maneuver: f64,
    pub distance_remaining: f64,
    pub duration_remaining: f64,
}

#[flutter_rust_bridge::frb(mirror(TripSummary))]
pub struct _TripSummary {
    pub distance_traveled: f64,
    pub snapped_distance_traveled: f64,
    pub started_at: DateTime<Utc>,
    pub ended_at: Option<DateTime<Utc>>,
}

#[flutter_rust_bridge::frb(mirror(RouteDeviation))]
pub enum _RouteDeviation {
    NoDeviation,
    OffRoute {
        deviation_from_route_line: f64,
    },
}



#[flutter_rust_bridge::frb(mirror(CourseFiltering))]
pub enum _CourseFiltering {
    SnapToRoute,
    Raw,
}

#[flutter_rust_bridge::frb(mirror(WaypointAdvanceMode))]
pub enum _WaypointAdvanceMode {
    WaypointWithinRange(f64),
}

pub enum FlutterRouteDeviationTracking {
    None,
    StaticThreshold {
        minimum_horizontal_accuracy: u16,
        max_acceptable_deviation: f64,
    },
}

impl From<FlutterRouteDeviationTracking> for ferrostar::deviation_detection::RouteDeviationTracking {
    fn from(tracking: FlutterRouteDeviationTracking) -> Self {
        match tracking {
            FlutterRouteDeviationTracking::None => ferrostar::deviation_detection::RouteDeviationTracking::None,
            FlutterRouteDeviationTracking::StaticThreshold {
                minimum_horizontal_accuracy,
                max_acceptable_deviation,
            } => ferrostar::deviation_detection::RouteDeviationTracking::StaticThreshold {
                minimum_horizontal_accuracy,
                max_acceptable_deviation,
            },
        }
    }
}

#[flutter_rust_bridge::frb(mirror(SerializableStepAdvanceCondition))]
pub enum _SerializableStepAdvanceCondition {
    Manual,
    DistanceToEndOfStep {
        distance: u16,
        minimum_horizontal_accuracy: u16,
    },
    DistanceFromStep {
        distance: u16,
        minimum_horizontal_accuracy: u16,
    },
    DistanceEntryExit {
        distance_to_end_of_step: u16,
        distance_after_end_step: u16,
        minimum_horizontal_accuracy: u16,
        has_reached_end_of_current_step: bool,
    },
    OrAdvanceConditions {
        conditions: Vec<SerializableStepAdvanceCondition>,
    },
    AndAdvanceConditions {
        conditions: Vec<SerializableStepAdvanceCondition>,
    },
}

pub struct FlutterNavigationControllerConfig {
    pub waypoint_advance: WaypointAdvanceMode,
    pub step_advance_condition: SerializableStepAdvanceCondition,
    pub arrival_step_advance_condition: SerializableStepAdvanceCondition,
    pub route_deviation_tracking: FlutterRouteDeviationTracking,
    pub snapped_location_course_filtering: CourseFiltering,
}

use ferrostar::navigation_controller::models::NavigationControllerConfig;

impl From<FlutterNavigationControllerConfig> for NavigationControllerConfig {
    fn from(val: FlutterNavigationControllerConfig) -> Self {
        Self {
            waypoint_advance: val.waypoint_advance,
            step_advance_condition: val.step_advance_condition.into(),
            arrival_step_advance_condition: val.arrival_step_advance_condition.into(),
            route_deviation_tracking: val.route_deviation_tracking.into(),
            snapped_location_course_filtering: val.snapped_location_course_filtering,
        }
    }
}

// Wrapper types for UserLocation and TripState because of SystemTime

pub struct FlutterUserLocation {
    pub coordinates: GeographicCoordinate,
    pub horizontal_accuracy: f64,
    pub course_over_ground: Option<CourseOverGround>,
    pub timestamp: DateTime<Utc>,
    pub speed: Option<Speed>,
}

impl From<FlutterUserLocation> for UserLocation {
    fn from(val: FlutterUserLocation) -> Self {
        UserLocation {
            coordinates: val.coordinates,
            horizontal_accuracy: val.horizontal_accuracy,
            course_over_ground: val.course_over_ground,
            timestamp: val.timestamp.into(),
            speed: val.speed,
        }
    }
}

impl From<UserLocation> for FlutterUserLocation {
    fn from(val: UserLocation) -> Self {
        FlutterUserLocation {
            coordinates: val.coordinates,
            horizontal_accuracy: val.horizontal_accuracy,
            course_over_ground: val.course_over_ground,
            timestamp: val.timestamp.into(),
            speed: val.speed,
        }
    }
}

pub enum FlutterTripState {
    Idle {
        user_location: Option<FlutterUserLocation>,
    },
    Navigating {
        current_step_geometry_index: Option<u64>,
        user_location: FlutterUserLocation,
        snapped_user_location: FlutterUserLocation,
        remaining_steps: Vec<RouteStep>,
        remaining_waypoints: Vec<Waypoint>,
        progress: TripProgress,
        summary: TripSummary,
        deviation: RouteDeviation,
        visual_instruction: Option<VisualInstruction>,
        spoken_instruction: Option<SpokenInstruction>,
        annotation_json: Option<String>,
    },
    Complete {
        user_location: FlutterUserLocation,
        summary: TripSummary,
    },
}

impl From<TripState> for FlutterTripState {
    fn from(val: TripState) -> Self {
        match val {
            TripState::Idle { user_location } => FlutterTripState::Idle {
                user_location: user_location.map(Into::into),
            },
            TripState::Navigating {
                current_step_geometry_index,
                user_location,
                snapped_user_location,
                remaining_steps,
                remaining_waypoints,
                progress,
                summary,
                deviation,
                visual_instruction,
                spoken_instruction,
                annotation_json,
            } => FlutterTripState::Navigating {
                current_step_geometry_index,
                user_location: user_location.into(),
                snapped_user_location: snapped_user_location.into(),
                remaining_steps,
                remaining_waypoints,
                progress,
                summary,
                deviation,
                visual_instruction,
                spoken_instruction,
                annotation_json,
            },
            TripState::Complete {
                user_location,
                summary,
            } => FlutterTripState::Complete {
                user_location: user_location.into(),
                summary,
            },
        }
    }
}

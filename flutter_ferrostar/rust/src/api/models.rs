pub use ferrostar::models::{
    BoundingBox, Congestion, GeographicCoordinate, Impact, Incident, IncidentType, LaneInfo,
    ManeuverModifier, ManeuverType, Route, RouteStep, SpokenInstruction, VisualInstruction,
    VisualInstructionContent, Waypoint, WaypointKind, BlockedLane, Speed, CourseOverGround,
    UserLocation
};
pub use ferrostar::routing_adapters::valhalla::{
    ValhallaLocationSearchFilter, ValhallaRoadClass, ValhallaWaypointPreferredSide,
    ValhallaWaypointProperties,
};
pub use ferrostar::navigation_controller::models::{
    TripProgress, TripState, TripSummary, CourseFiltering, WaypointAdvanceMode
};
pub use ferrostar::deviation_detection::{RouteDeviation, RouteDeviationTracking};
pub use ferrostar::navigation_controller::step_advance::SerializableStepAdvanceCondition;
use chrono::{DateTime, Utc};
use uuid::Uuid;
use std::time::SystemTime;
use flutter_rust_bridge::frb;

#[flutter_rust_bridge::frb(mirror(GeographicCoordinate))]
pub struct _GeographicCoordinate {
    pub lat: f64,
    pub lng: f64,
}

#[flutter_rust_bridge::frb(mirror(Waypoint))]
pub struct _Waypoint {
    pub coordinate: GeographicCoordinate,
    pub kind: WaypointKind,
    pub properties: Option<Vec<u8>>,
}

#[flutter_rust_bridge::frb(mirror(WaypointKind))]
pub enum _WaypointKind {
    Break,
    Via,
}

#[flutter_rust_bridge::frb(mirror(ValhallaWaypointPreferredSide))]
pub enum _ValhallaWaypointPreferredSide {
    Same,
    Opposite,
    Either,
}

#[flutter_rust_bridge::frb(mirror(ValhallaRoadClass))]
pub enum _ValhallaRoadClass {
    Motorway,
    Trunk,
    Primary,
    Secondary,
    Tertiary,
    Unclassified,
    Residential,
    ServiceOther,
}

#[flutter_rust_bridge::frb(mirror(ValhallaLocationSearchFilter))]
pub struct _ValhallaLocationSearchFilter {
    pub exclude_tunnel: Option<bool>,
    pub exclude_bridge: Option<bool>,
    pub exclude_tolls: Option<bool>,
    pub exclude_ferry: Option<bool>,
    pub exclude_ramp: Option<bool>,
    pub exclude_closures: Option<bool>,
    pub min_road_class: Option<ValhallaRoadClass>,
    pub max_road_class: Option<ValhallaRoadClass>,
    pub level: Option<f32>,
}

#[flutter_rust_bridge::frb(mirror(ValhallaWaypointProperties))]
pub struct _ValhallaWaypointProperties {
    pub heading: Option<u16>,
    pub heading_tolerance: Option<u16>,
    pub minimum_reachability: Option<u16>,
    pub radius: Option<u16>,
    pub preferred_side: Option<ValhallaWaypointPreferredSide>,
    pub display_coordinate: Option<GeographicCoordinate>,
    pub search_cutoff: Option<u32>,
    pub node_snap_tolerance: Option<u16>,
    pub street_side_tolerance: Option<u16>,
    pub street_side_max_distance: Option<u16>,
    pub street_side_cutoff: Option<ValhallaRoadClass>,
    pub search_filter: Option<ValhallaLocationSearchFilter>,
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
    WaypointAlongAdvancingStep(f64),
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
        calculate_while_off_route: bool,
    },
    DistanceEntryExit {
        distance_to_end_of_step: u16,
        distance_after_end_step: u16,
        minimum_horizontal_accuracy: u16,
        has_reached_end_of_current_step: bool,
    },
    DistanceEntryAndSnappedExit {
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

pub struct NavigationControllerConfig {
    pub waypoint_advance: WaypointAdvanceMode,
    pub step_advance_condition: SerializableStepAdvanceCondition,
    pub arrival_step_advance_condition: SerializableStepAdvanceCondition,
    pub route_deviation_tracking: RouteDeviationTracking,
    pub snapped_location_course_filtering: CourseFiltering,
}

impl From<NavigationControllerConfig> for ferrostar::navigation_controller::models::NavigationControllerConfig {
    fn from(config: NavigationControllerConfig) -> Self {
        ferrostar::navigation_controller::models::NavigationControllerConfig {
            waypoint_advance: config.waypoint_advance,
            step_advance_condition: config.step_advance_condition.into(),
            arrival_step_advance_condition: config.arrival_step_advance_condition.into(),
            route_deviation_tracking: config.route_deviation_tracking,
            snapped_location_course_filtering: config.snapped_location_course_filtering,
        }
    }
}

pub fn create_navigation_controller_config(
    waypoint_advance: WaypointAdvanceMode,
    step_advance_condition: SerializableStepAdvanceCondition,
    arrival_step_advance_condition: SerializableStepAdvanceCondition,
    route_deviation_tracking: RouteDeviationTracking,
    snapped_location_course_filtering: CourseFiltering,
) -> NavigationControllerConfig {
    NavigationControllerConfig {
        waypoint_advance,
        step_advance_condition,
        arrival_step_advance_condition,
        route_deviation_tracking,
        snapped_location_course_filtering,
    }
}

pub fn create_route_deviation_tracking_none() -> RouteDeviationTracking {
    RouteDeviationTracking::None
}

pub fn create_route_deviation_tracking_static_threshold(
    minimum_horizontal_accuracy: u16,
    max_acceptable_deviation: f64,
) -> RouteDeviationTracking {
    RouteDeviationTracking::StaticThreshold {
        minimum_horizontal_accuracy,
        max_acceptable_deviation,
    }
}

#[flutter_rust_bridge::frb(mirror(UserLocation))]
pub struct _UserLocation {
    pub coordinates: GeographicCoordinate,
    pub horizontal_accuracy: f64,
    pub course_over_ground: Option<CourseOverGround>,
    #[frb(ignore)]
    pub timestamp: std::time::SystemTime,
    pub speed: Option<Speed>,
}

#[flutter_rust_bridge::frb(mirror(TripState))]
#[frb(non_opaque)]
pub enum _TripState {
    Idle {
        #[frb(opaque)]
        user_location: Option<UserLocation>,
    },
    Navigating {
        current_step_geometry_index: Option<u64>,
        #[frb(opaque)]
        user_location: UserLocation,
        #[frb(opaque)]
        snapped_user_location: UserLocation,
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
        #[frb(opaque)]
        user_location: UserLocation,
        summary: TripSummary,
    },
}

pub fn create_user_location(
    coordinates: GeographicCoordinate,
    horizontal_accuracy: f64,
    course_over_ground: Option<CourseOverGround>,
    timestamp: DateTime<Utc>,
    speed: Option<Speed>,
) -> UserLocation {
    UserLocation {
        coordinates,
        horizontal_accuracy,
        course_over_ground,
        timestamp: timestamp.into(),
        speed,
    }
}

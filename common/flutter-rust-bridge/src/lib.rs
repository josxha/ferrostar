mod frb_generated; /* AUTO INJECTED BY flutter_rust_bridge. This line may not be accurate, and you can change it according to your needs. */

use chrono::{DateTime, Utc};
use ferrostar::models::{
    BoundingBox,
    CourseOverGround,
    GeographicCoordinate,
    Incident,
    Route,
    RouteStep,
    Speed,
    SpokenInstruction,
    UserLocation,
    VisualInstruction,
    Waypoint,
    WaypointKind,
};
use ferrostar::navigation_controller::{create_navigator, Navigator};
use ferrostar::navigation_controller::models::{CourseFiltering, NavState, NavigationControllerConfig, TripState, WaypointAdvanceMode};
use ferrostar::navigation_controller::step_advance::conditions::ManualStepCondition;
use ferrostar::routing_adapters::osrm::OsrmResponseParser;
use ferrostar::routing_adapters::valhalla::{self, ValhallaHttpRequestGenerator as CoreValhallaGenerator, ValhallaWaypointProperties};
use ferrostar::routing_adapters::{RouteRequest, RouteRequestGenerator, RouteResponseParser};
use ferrostar::deviation_detection::RouteDeviationTracking;
use ferrostar::simulation::{
    advance_location_simulation as core_advance_location_simulation,
    location_simulation_from_coordinates as core_location_simulation_from_coordinates,
    location_simulation_from_polyline as core_location_simulation_from_polyline,
    location_simulation_from_route as core_location_simulation_from_route,
    LocationBias as CoreLocationBias,
    LocationSimulationState as CoreLocationSimulationState,
    SimulationError as CoreSimulationError,
};
use flutter_rust_bridge::frb;
use once_cell::sync::Lazy;
use serde_json::Map;
use std::collections::HashMap;
use std::sync::atomic::{AtomicU64, Ordering};
use std::sync::{Arc, Mutex};

static NEXT_ID: AtomicU64 = AtomicU64::new(1);
fn next_id() -> u64 {
    NEXT_ID.fetch_add(1, Ordering::Relaxed)
}

static VALHALLA_GENERATORS: Lazy<Mutex<HashMap<u64, CoreValhallaGenerator>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));
static NAV_CONTROLLERS: Lazy<Mutex<HashMap<u64, Arc<dyn Navigator>>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));
static NAV_STATES: Lazy<Mutex<HashMap<u64, NavState>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));
static ROUTES: Lazy<Mutex<HashMap<u64, Route>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));
static SIM_STATES: Lazy<Mutex<HashMap<u64, CoreLocationSimulationState>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));

#[frb]
pub fn passthrough_coordinate(coord: GeographicCoordinate) -> GeographicCoordinate {
    coord
}

/// Helper to build a `GeographicCoordinate` from primitives (Dart cannot construct opaque types directly).
#[frb]
pub fn make_geographic_coordinate(lat: f64, lng: f64) -> GeographicCoordinate {
    GeographicCoordinate { lat, lng }
}

/// Build a bounding box from corner coordinates.
#[frb]
pub fn make_bounding_box(sw_lat: f64, sw_lng: f64, ne_lat: f64, ne_lng: f64) -> BoundingBox {
    BoundingBox {
        sw: GeographicCoordinate { lat: sw_lat, lng: sw_lng },
        ne: GeographicCoordinate { lat: ne_lat, lng: ne_lng },
    }
}

/// Convenience helper to build a break waypoint from primitives.
#[frb]
pub fn make_break_waypoint(lat: f64, lng: f64) -> Waypoint {
    Waypoint {
        coordinate: GeographicCoordinate { lat, lng },
        kind: WaypointKind::Break,
        properties: None,
    }
}

fn simple_route_from_coords(coords: &[GeographicCoordinate]) -> Route {
    let sw_lat = coords.iter().map(|c| c.lat).fold(f64::INFINITY, f64::min);
    let sw_lng = coords.iter().map(|c| c.lng).fold(f64::INFINITY, f64::min);
    let ne_lat = coords.iter().map(|c| c.lat).fold(f64::NEG_INFINITY, f64::max);
    let ne_lng = coords.iter().map(|c| c.lng).fold(f64::NEG_INFINITY, f64::max);

    let bbox = BoundingBox {
        sw: GeographicCoordinate { lat: sw_lat, lng: sw_lng },
        ne: GeographicCoordinate { lat: ne_lat, lng: ne_lng },
    };

    let waypoints = vec![
        Waypoint { coordinate: coords.first().copied().unwrap(), kind: WaypointKind::Break, properties: None },
        Waypoint { coordinate: coords.last().copied().unwrap(), kind: WaypointKind::Break, properties: None },
    ];

    let step = RouteStep {
        geometry: coords.to_vec(),
        distance: 100.0,
        duration: 60.0,
        road_name: Some("Test Road".to_string()),
        exits: vec![],
        instruction: "Go straight".to_string(),
        visual_instructions: Vec::<VisualInstruction>::new(),
        spoken_instructions: Vec::<SpokenInstruction>::new(),
        annotations: None,
        incidents: Vec::<Incident>::new(),
    };

    Route {
        geometry: coords.to_vec(),
        bbox,
        distance: 100.0,
        waypoints,
        steps: vec![step],
    }
}

/// A ready-made demo route for integration testing.
#[frb]
pub fn demo_route() -> Route {
    let coords = vec![
        GeographicCoordinate { lat: 37.7749, lng: -122.4194 },
        GeographicCoordinate { lat: 37.7750, lng: -122.4195 },
    ];
    simple_route_from_coords(&coords)
}

/// Shim wrapper around the core Valhalla HTTP request generator using a handle map.
#[frb(non_opaque)]
pub struct ValhallaHttpRequestGenerator {
    id: u64,
}

impl ValhallaHttpRequestGenerator {
    /// Creates a Valhalla request generator with no additional options.
    #[frb(sync)]
    pub fn new(endpoint_url: String, profile: String) -> Self {
        let id = next_id();
        let gen = CoreValhallaGenerator::new(endpoint_url, profile, Map::new());
        VALHALLA_GENERATORS.lock().unwrap().insert(id, gen);
        Self { id }
    }

    pub fn generate_request(
        &self,
        user_location: UserLocation,
        waypoints: Vec<Waypoint>,
    ) -> Result<RouteRequest, String> {
        let guard = VALHALLA_GENERATORS.lock().unwrap();
        let gen = guard
            .get(&self.id)
            .ok_or_else(|| "Generator handle not found".to_string())?;
        gen.generate_request(user_location, waypoints)
            .map_err(|e| format!("{e:?}"))
    }
}

/// Demo navigation controller configuration for integration tests.
#[frb]
pub fn demo_navigation_config() -> NavigationControllerConfig {
    NavigationControllerConfig {
        waypoint_advance: WaypointAdvanceMode::WaypointWithinRange(15.0),
        step_advance_condition: Arc::new(ManualStepCondition),
        arrival_step_advance_condition: Arc::new(ManualStepCondition),
        route_deviation_tracking: RouteDeviationTracking::None,
        snapped_location_course_filtering: CourseFiltering::SnapToRoute,
    }
}

/// Demo navigation controller using an internal route/config so Dart does not need to construct them.
#[frb]
pub fn demo_navigation_controller() -> FlutterNavigationController {
    FlutterNavigationController::new(demo_route(), demo_navigation_config())
}

#[frb(non_opaque)]
pub struct RouteHandle {
    id: u64,
}

/// Store a route in a handle map to prevent premature disposal on the Dart side.
#[frb]
pub fn retain_route(route: Route) -> RouteHandle {
    let id = next_id();
    ROUTES.lock().unwrap().insert(id, route);
    RouteHandle { id }
}

/// Release a previously retained route handle.
#[frb]
pub fn release_route(handle: RouteHandle) {
    ROUTES.lock().unwrap().remove(&handle.id);
}

fn route_from_handle(handle: &RouteHandle) -> Route {
    ROUTES
        .lock()
        .unwrap()
        .get(&handle.id)
        .cloned()
        .expect("Route handle not found")
}

#[frb]
pub fn navigation_controller_from_route_handle(
    handle: RouteHandle,
    config: NavigationControllerConfig,
) -> FlutterNavigationController {
    FlutterNavigationController::new(route_from_handle(&handle), config)
}

/// Demo user location on the start of the demo route.
#[frb]
pub fn demo_user_location_start() -> UserLocation {
    UserLocation {
        coordinates: GeographicCoordinate { lat: 37.7749, lng: -122.4194 },
        horizontal_accuracy: 5.0,
        course_over_ground: None,
        timestamp: Utc::now().into(),
        speed: None,
    }
}

/// Demo user location slightly along the route.
#[frb]
pub fn demo_user_location_next() -> UserLocation {
    UserLocation {
        coordinates: GeographicCoordinate { lat: 37.77495, lng: -122.41945 },
        horizontal_accuracy: 5.0,
        course_over_ground: None,
        timestamp: Utc::now().into(),
        speed: None,
    }
}

/// Parses an OSRM/Valhalla response into routes using the core parser.
pub fn parse_osrm_response(response: Vec<u8>, polyline_precision: u32) -> Result<Vec<Route>, String> {
    let parser = OsrmResponseParser::new(polyline_precision);
    parser
        .parse_response(response)
        .map_err(|e| format!("Failed to parse response: {e:?}"))
}

/// Convenience helper to build a waypoint with Valhalla rich properties.
pub fn create_waypoint_with_valhalla_properties(
    coordinate: GeographicCoordinate,
    kind: WaypointKind,
    properties: ValhallaWaypointProperties,
 ) -> Waypoint {
    valhalla::create_waypoint_with_valhalla_properties(coordinate, kind, properties)
}

/// Create default Valhalla waypoint properties (workaround for Dart-side opaque type construction).
#[frb]
pub fn default_valhalla_waypoint_properties() -> ValhallaWaypointProperties {
    ValhallaWaypointProperties::default()
}

/// Convenience accessor for the common Break waypoint kind.
#[frb]
pub fn waypoint_kind_break() -> WaypointKind {
    WaypointKind::Break
}

/// Flutter-facing wrapper around the navigation controller using handle-based storage.
#[frb(non_opaque)]
pub struct FlutterNavigationController {
    id: u64,
}

impl FlutterNavigationController {
    pub fn new(route: Route, config: NavigationControllerConfig) -> Self {
        let id = next_id();
        let inner = create_navigator(route, config, false);
        NAV_CONTROLLERS.lock().unwrap().insert(id, inner);
        Self { id }
    }

    #[frb(sync)]
    pub fn from_route_handle(handle: RouteHandle, config: NavigationControllerConfig) -> Self {
        let route = route_from_handle(&handle);
        Self::new(route, config)
    }

    pub fn get_initial_state(&self, location: UserLocation) -> FlutterNavState {
        let navs = NAV_CONTROLLERS.lock().unwrap();
        let nav = navs.get(&self.id).expect("Navigator handle not found");
        let state = nav.get_initial_state(location);
        let id = next_id();
        NAV_STATES.lock().unwrap().insert(id, state);
        FlutterNavState { id }
    }

    pub fn advance_to_next_step(&self, state: &FlutterNavState) -> FlutterNavState {
        let navs = NAV_CONTROLLERS.lock().unwrap();
        let nav = navs.get(&self.id).expect("Navigator handle not found");
        let mut states = NAV_STATES.lock().unwrap();
        let current = states.get(&state.id).expect("State handle not found");
        let new_state = nav.advance_to_next_step(current.clone());
        let id = next_id();
        states.insert(id, new_state);
        FlutterNavState { id }
    }

    pub fn update_user_location(&self, location: UserLocation, state: &FlutterNavState) -> FlutterNavState {
        let navs = NAV_CONTROLLERS.lock().unwrap();
        let nav = navs.get(&self.id).expect("Navigator handle not found");
        let mut states = NAV_STATES.lock().unwrap();
        let current = states.get(&state.id).expect("State handle not found");
        let new_state = nav.update_user_location(location, current.clone());
        let id = next_id();
        states.insert(id, new_state);
        FlutterNavState { id }
    }
}

#[frb(non_opaque)]
pub struct FlutterNavState {
    id: u64,
}

impl FlutterNavState {
    pub fn trip_state(&self) -> TripState {
        let states = NAV_STATES.lock().unwrap();
        let current = states.get(&self.id).expect("State handle not found");
        current.trip_state()
    }
}

/// Human-readable variant name for a `TripState`.
#[frb]
pub fn trip_state_variant(state: TripState) -> String {
    match state {
        TripState::Idle { .. } => "Idle".to_string(),
        TripState::Navigating { .. } => "Navigating".to_string(),
        TripState::Complete { .. } => "Complete".to_string(),
    }
}

/// Sync helper to create a user location (keeps Flutter API compatibility).
#[frb(sync)]
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

/// Simple coordinate DTO to allow Dart to read lat/lng.
#[frb(non_opaque)]
pub struct SimpleGeographicCoordinate {
    pub lat: f64,
    pub lng: f64,
}

#[frb(non_opaque)]
pub struct SimpleRouteStep {
    pub geometry: Vec<SimpleGeographicCoordinate>,
    pub instruction: String,
}

/// Extract lat/lng from an opaque coordinate.
#[frb]
pub fn geographic_coordinate_components(coord: GeographicCoordinate) -> SimpleGeographicCoordinate {
    SimpleGeographicCoordinate { lat: coord.lat, lng: coord.lng }
}

#[frb(non_opaque)]
pub struct UserLocationSnapshot {
    pub coordinates: SimpleGeographicCoordinate,
    pub horizontal_accuracy: f64,
}

/// Extract a test-friendly view of `UserLocation` without exposing core internals to Dart.
#[frb]
pub fn describe_user_location(location: UserLocation) -> UserLocationSnapshot {
    UserLocationSnapshot {
        coordinates: SimpleGeographicCoordinate {
            lat: location.coordinates.lat,
            lng: location.coordinates.lng,
        },
        horizontal_accuracy: location.horizontal_accuracy,
    }
}

/// Build a simulation using plain lat/lng inputs to avoid opaque types on the Dart side.
#[frb]
pub fn location_simulation_from_lat_lng(
    coordinates: Vec<SimpleGeographicCoordinate>,
    resample_distance: Option<f64>,
    bias: LocationBias,
) -> Result<LocationSimulationState, SimulationError> {
    let coords: Vec<GeographicCoordinate> = coordinates
        .into_iter()
        .map(|c| GeographicCoordinate { lat: c.lat, lng: c.lng })
        .collect();
    core_location_simulation_from_coordinates(&coords, resample_distance, bias.into())
        .map(LocationSimulationState::from)
        .map_err(SimulationError::from)
}

/// Convenience wrapper to generate a Valhalla request from plain coordinate inputs.
#[frb]
pub fn generate_valhalla_request_simple(
    endpoint_url: String,
    profile: String,
    user_location: SimpleGeographicCoordinate,
    waypoints: Vec<SimpleGeographicCoordinate>,
) -> Result<FerrostarRouteRequest, String> {
    let user_location = UserLocation {
        coordinates: GeographicCoordinate {
            lat: user_location.lat,
            lng: user_location.lng,
        },
        horizontal_accuracy: 5.0,
        course_over_ground: None,
        timestamp: Utc::now().into(),
        speed: None,
    };

    let valhalla_props = ValhallaWaypointProperties::default();
    let waypoints: Vec<Waypoint> = waypoints
        .into_iter()
        .map(|coord| valhalla::create_waypoint_with_valhalla_properties(
            GeographicCoordinate {
                lat: coord.lat,
                lng: coord.lng,
            },
            WaypointKind::Break,
            valhalla_props.clone(),
        ))
        .collect();

    generate_valhalla_request(endpoint_url, profile, user_location, waypoints)
}

/// Extract route geometry into simple coordinates for Dart consumption.
#[frb]
pub fn route_geometry(route: Route) -> Vec<SimpleGeographicCoordinate> {
    route
        .geometry
        .iter()
        .map(|c| SimpleGeographicCoordinate { lat: c.lat, lng: c.lng })
        .collect()
}

/// Extract route geometry from a retained handle.
#[frb]
pub fn route_geometry_from_handle(handle: RouteHandle) -> Vec<SimpleGeographicCoordinate> {
    route_from_handle(&handle)
        .geometry
        .iter()
        .map(|c| SimpleGeographicCoordinate { lat: c.lat, lng: c.lng })
        .collect()
}

/// Extract per-step geometry and instruction from a retained handle.
#[frb]
pub fn route_steps_from_handle(handle: RouteHandle) -> Vec<SimpleRouteStep> {
    route_from_handle(&handle)
        .steps
        .iter()
        .map(|s| SimpleRouteStep {
            geometry: s
                .geometry
                .iter()
                .map(|c| SimpleGeographicCoordinate { lat: c.lat, lng: c.lng })
                .collect(),
            instruction: s.instruction.clone(),
        })
        .collect()
}

/// Dart-friendly representation of route requests.
#[frb(non_opaque)]
pub enum FerrostarRouteRequest {
    HttpGet { url: String, headers: Vec<(String, String)> },
    HttpPost { url: String, headers: Vec<(String, String)>, body: Vec<u8> },
}

/// Generate a Valhalla request and return a Dart-friendly shape.
#[frb]
pub fn generate_valhalla_request(
    endpoint_url: String,
    profile: String,
    user_location: UserLocation,
    waypoints: Vec<Waypoint>,
) -> Result<FerrostarRouteRequest, String> {
    let gen = CoreValhallaGenerator::new(endpoint_url, profile, Map::new());
    let req = gen
        .generate_request(user_location, waypoints)
        .map_err(|e| format!("{e:?}"))?;
    match req {
        RouteRequest::HttpGet { url, headers } => Ok(FerrostarRouteRequest::HttpGet {
            url,
            headers: headers.into_iter().collect(),
        }),
        RouteRequest::HttpPost { url, headers, body } => Ok(FerrostarRouteRequest::HttpPost {
            url,
            headers: headers.into_iter().collect(),
            body,
        }),
    }
}

/// Controls how simulated locations deviate from the actual route line.
#[frb(non_opaque)]
pub enum LocationBias {
    Left(f64),
    Right(f64),
    Random(f64),
    None,
}

impl From<CoreLocationBias> for LocationBias {
    fn from(value: CoreLocationBias) -> Self {
        match value {
            CoreLocationBias::Left(v) => LocationBias::Left(v),
            CoreLocationBias::Right(v) => LocationBias::Right(v),
            CoreLocationBias::Random(v) => LocationBias::Random(v),
            CoreLocationBias::None => LocationBias::None,
        }
    }
}

impl From<LocationBias> for CoreLocationBias {
    fn from(value: LocationBias) -> Self {
        match value {
            LocationBias::Left(v) => CoreLocationBias::Left(v),
            LocationBias::Right(v) => CoreLocationBias::Right(v),
            LocationBias::Random(v) => CoreLocationBias::Random(v),
            LocationBias::None => CoreLocationBias::None,
        }
    }
}

#[frb(non_opaque)]
pub enum SimulationError {
    PolylineError { error: String },
    NotEnoughPoints,
}

impl From<CoreSimulationError> for SimulationError {
    fn from(value: CoreSimulationError) -> Self {
        match value {
            CoreSimulationError::PolylineError { error } => SimulationError::PolylineError { error },
            CoreSimulationError::NotEnoughPoints => SimulationError::NotEnoughPoints,
        }
    }
}

impl From<SimulationError> for CoreSimulationError {
    fn from(value: SimulationError) -> Self {
        match value {
            SimulationError::PolylineError { error } => CoreSimulationError::PolylineError { error },
            SimulationError::NotEnoughPoints => CoreSimulationError::NotEnoughPoints,
        }
    }
}

/// The current state of a location simulation stored via handle.
#[frb(non_opaque)]
pub struct LocationSimulationState {
    id: u64,
}

impl From<CoreLocationSimulationState> for LocationSimulationState {
    fn from(inner: CoreLocationSimulationState) -> Self {
        let id = next_id();
        SIM_STATES.lock().unwrap().insert(id, inner);
        LocationSimulationState { id }
    }
}

impl LocationSimulationState {
    /// Access the current simulated location.
    pub fn current_location(&self) -> UserLocation {
        let states = SIM_STATES.lock().unwrap();
        let state = states.get(&self.id).expect("Simulation handle not found");
        state.current_location.clone()
    }
}

/// Creates a location simulation from a set of coordinates.
#[frb]
pub fn location_simulation_from_coordinates(
    coordinates: Vec<GeographicCoordinate>,
    resample_distance: Option<f64>,
    bias: LocationBias,
) -> Result<LocationSimulationState, SimulationError> {
    core_location_simulation_from_coordinates(&coordinates, resample_distance, bias.into())
        .map(LocationSimulationState::from)
        .map_err(SimulationError::from)
}

/// Creates a location simulation from a route.
#[frb]
pub fn location_simulation_from_route(
    route: Route,
    resample_distance: Option<f64>,
    bias: LocationBias,
) -> Result<LocationSimulationState, SimulationError> {
    core_location_simulation_from_route(&route, resample_distance, bias.into())
        .map(LocationSimulationState::from)
        .map_err(SimulationError::from)
}

/// Creates a location simulation from a polyline.
#[frb]
pub fn location_simulation_from_polyline(
    polyline: String,
    precision: u32,
    resample_distance: Option<f64>,
    bias: LocationBias,
) -> Result<LocationSimulationState, SimulationError> {
    core_location_simulation_from_polyline(&polyline, precision, resample_distance, bias.into())
        .map(LocationSimulationState::from)
        .map_err(SimulationError::from)
}

/// Advances the simulation to the next location.
#[frb]
pub fn advance_location_simulation(state: &LocationSimulationState) -> LocationSimulationState {
    let current = {
        let mut states = SIM_STATES.lock().unwrap();
        states
            .remove(&state.id)
            .expect("Simulation handle not found")
    };
    core_advance_location_simulation(&current).into()
}

/// Convenience wrapper to build a simulation from the demo route.
#[frb]
pub fn location_simulation_from_demo_route(
    resample_distance: Option<f64>,
    bias: LocationBias,
) -> Result<LocationSimulationState, SimulationError> {
    location_simulation_from_route(demo_route(), resample_distance, bias)
}

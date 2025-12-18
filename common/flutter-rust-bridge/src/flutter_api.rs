use crate::models::{Route, UserLocation, Waypoint, WaypointKind, GeographicCoordinate};
use crate::navigation_controller::{create_navigator, Navigator};
use crate::navigation_controller::models::NavState;
use crate::routing_adapters::osrm::OsrmResponseParser;
use crate::routing_adapters::valhalla::{self, ValhallaHttpRequestGenerator as CoreValhallaGenerator};
use crate::routing_adapters::RouteRequest;
use flutter_rust_bridge::frb;
use once_cell::sync::Lazy;
use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use std::sync::atomic::{AtomicU64, Ordering};

static NEXT_ID: AtomicU64 = AtomicU64::new(1);
fn next_id() -> u64 {
    NEXT_ID.fetch_add(1, Ordering::Relaxed)
}

static VALHALLA_GENERATORS: Lazy<Mutex<HashMap<u64, CoreValhallaGenerator>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));

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
        let gen = CoreValhallaGenerator::new(endpoint_url, profile, serde_json::Map::new());
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
    properties: valhalla::ValhallaWaypointProperties,
) -> Waypoint {
    valhalla::create_waypoint_with_valhalla_properties(coordinate, kind, properties)
}

static NAV_CONTROLLERS: Lazy<Mutex<HashMap<u64, Arc<dyn Navigator>>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));
static NAV_STATES: Lazy<Mutex<HashMap<u64, NavState>>> =
    Lazy::new(|| Mutex::new(HashMap::new()));

/// Flutter-facing wrapper around the navigation controller using handle-based storage.
#[frb(non_opaque)]
pub struct FlutterNavigationController {
    id: u64,
}

#[frb(non_opaque)]
pub struct FlutterNavState {
    id: u64,
}

impl FlutterNavigationController {
    pub fn new(route: Route, config: crate::navigation_controller::models::NavigationControllerConfig) -> Self {
        let id = next_id();
        let inner = create_navigator(route, config, false);
        NAV_CONTROLLERS.lock().unwrap().insert(id, inner);
        Self { id }
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

impl FlutterNavState {
    pub fn trip_state(&self) -> crate::navigation_controller::models::TripState {
        let states = NAV_STATES.lock().unwrap();
        let current = states.get(&self.id).expect("State handle not found");
        current.trip_state()
    }
}

/// Sync helper to create a user location (keeps Flutter API compatibility).
#[frb(sync)]
pub fn create_user_location(
    coordinates: GeographicCoordinate,
    horizontal_accuracy: f64,
    course_over_ground: Option<crate::models::CourseOverGround>,
    timestamp: chrono::DateTime<chrono::Utc>,
    speed: Option<crate::models::Speed>,
) -> UserLocation {
    UserLocation {
        coordinates,
        horizontal_accuracy,
        course_over_ground,
        timestamp: timestamp.into(),
        speed,
    }
}

/// Re-export route request type for Dart.
pub use RouteRequest as FerrostarRouteRequest;
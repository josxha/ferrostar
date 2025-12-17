use crate::models::{Route, UserLocation, Waypoint, WaypointKind, GeographicCoordinate};
use crate::navigation_controller::{create_navigator, Navigator};
use crate::navigation_controller::models::NavState;
use crate::routing_adapters::osrm::OsrmResponseParser;
use crate::routing_adapters::valhalla::{self, ValhallaHttpRequestGenerator as CoreValhallaGenerator};
use crate::routing_adapters::RouteRequest;
use flutter_rust_bridge::frb;
use std::sync::Arc;

/// Opaque wrapper around the core Valhalla HTTP request generator.
#[frb(opaque)]
pub struct ValhallaHttpRequestGenerator {
    inner: CoreValhallaGenerator,
}

impl ValhallaHttpRequestGenerator {
    /// Creates a Valhalla request generator with no additional options.
    #[frb(sync)]
    pub fn new(endpoint_url: String, profile: String) -> Self {
        Self {
            inner: CoreValhallaGenerator::new(endpoint_url, profile, serde_json::Map::new()),
        }
    }

    pub fn generate_request(
        &self,
        user_location: UserLocation,
        waypoints: Vec<Waypoint>,
    ) -> Result<RouteRequest, String> {
        self.inner
            .generate_request(user_location, waypoints)
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

/// Flutter-facing wrapper around the navigation controller.
#[frb(opaque)]
pub struct FlutterNavigationController {
    inner: Arc<dyn Navigator>,
}

impl FlutterNavigationController {
    pub fn new(route: Route, config: crate::navigation_controller::models::NavigationControllerConfig) -> Self {
        let inner = create_navigator(route, config, false);
        Self { inner }
    }

    pub fn get_initial_state(&self, location: UserLocation) -> FlutterNavState {
        let state = self.inner.get_initial_state(location);
        FlutterNavState { inner: state }
    }

    pub fn advance_to_next_step(&self, state: &FlutterNavState) -> FlutterNavState {
        let new_state = self.inner.advance_to_next_step(state.inner.clone());
        FlutterNavState { inner: new_state }
    }

    pub fn update_user_location(&self, location: UserLocation, state: &FlutterNavState) -> FlutterNavState {
        let new_state = self.inner.update_user_location(location, state.inner.clone());
        FlutterNavState { inner: new_state }
    }
}

#[frb(opaque)]
pub struct FlutterNavState {
    pub(crate) inner: NavState,
}

impl FlutterNavState {
    pub fn trip_state(&self) -> crate::navigation_controller::models::TripState {
        self.inner.trip_state()
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
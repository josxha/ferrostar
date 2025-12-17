mod frb_generated; /* AUTO INJECTED BY flutter_rust_bridge. This line may not be accurate, and you can change it according to your needs. */

use chrono::{DateTime, Utc};
use ferrostar::models::{CourseOverGround, GeographicCoordinate, Route, Speed, UserLocation, Waypoint, WaypointKind};
use ferrostar::navigation_controller::{create_navigator, Navigator};
use ferrostar::navigation_controller::models::{NavState, NavigationControllerConfig, TripState};
use ferrostar::routing_adapters::osrm::OsrmResponseParser;
use ferrostar::routing_adapters::valhalla::{self, ValhallaHttpRequestGenerator as CoreValhallaGenerator, ValhallaWaypointProperties};
use ferrostar::routing_adapters::{RouteRequest, RouteRequestGenerator, RouteResponseParser};
use flutter_rust_bridge::frb;
use serde_json::Map;
use std::sync::Arc;

#[frb]
pub fn passthrough_coordinate(coord: GeographicCoordinate) -> GeographicCoordinate {
    coord
}

/// Helper to build a `GeographicCoordinate` from primitives (Dart cannot construct opaque types directly).
#[frb]
pub fn make_geographic_coordinate(lat: f64, lng: f64) -> GeographicCoordinate {
    GeographicCoordinate { lat, lng }
}

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
            inner: CoreValhallaGenerator::new(endpoint_url, profile, Map::new()),
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

/// Flutter-facing wrapper around the navigation controller.
#[frb(opaque)]
pub struct FlutterNavigationController {
    inner: Arc<dyn Navigator>,
}

impl FlutterNavigationController {
    pub fn new(route: Route, config: NavigationControllerConfig) -> Self {
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
    pub fn trip_state(&self) -> TripState {
        self.inner.trip_state()
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

/// Extract route geometry into simple coordinates for Dart consumption.
#[frb]
pub fn route_geometry(route: Route) -> Vec<SimpleGeographicCoordinate> {
    route
        .geometry
        .iter()
        .map(|c| SimpleGeographicCoordinate { lat: c.lat, lng: c.lng })
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

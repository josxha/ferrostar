use crate::api::models::{GeographicCoordinate, Route, UserLocation, Waypoint, WaypointKind, ValhallaWaypointProperties};
use ferrostar::routing_adapters::osrm::OsrmResponseParser;
use ferrostar::routing_adapters::valhalla::ValhallaHttpRequestGenerator as FerrostarValhallaGenerator;
use ferrostar::routing_adapters::valhalla::create_waypoint_with_valhalla_properties as ferro_create_waypoint_with_valhalla_properties;
use ferrostar::routing_adapters::{RouteRequestGenerator, RouteResponseParser};
use flutter_rust_bridge::frb;
use std::collections::HashMap;

pub use ferrostar::routing_adapters::RouteRequest as FerrostarRouteRequest;

#[frb(mirror(FerrostarRouteRequest))]
pub enum _RouteRequest {
    HttpPost {
        url: String,
        headers: HashMap<String, String>,
        body: Vec<u8>,
    },
    HttpGet {
        url: String,
        headers: HashMap<String, String>,
    },
}

pub struct ValhallaHttpRequestGenerator {
    inner: FerrostarValhallaGenerator,
}

impl ValhallaHttpRequestGenerator {
    pub fn new(endpoint_url: String, profile: String) -> Self {
        Self {
            inner: FerrostarValhallaGenerator::new(endpoint_url, profile, serde_json::Map::new()),
        }
    }

    pub fn generate_request(&self, user_location: UserLocation, waypoints: Vec<Waypoint>) -> Result<FerrostarRouteRequest, String> {
        self.inner.generate_request(user_location, waypoints)
            .map_err(|e| format!("{:?}", e))
    }
}

pub fn parse_osrm_response(response: Vec<u8>, polyline_precision: u32) -> Result<Vec<Route>, String> {
    let parser = OsrmResponseParser::new(polyline_precision);
    parser.parse_response(response)
        .map_err(|e| format!("Failed to parse response: {:?}", e))
}

pub fn create_waypoint_with_valhalla_properties(
    coordinate: GeographicCoordinate,
    kind: WaypointKind,
    properties: ValhallaWaypointProperties,
) -> Waypoint {
    ferro_create_waypoint_with_valhalla_properties(coordinate, kind, properties)
}

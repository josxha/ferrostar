use ferrostar::models::GeographicCoordinate;
use ferrostar::navigation_controller::NavigationController;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

pub fn create_coordinate_string(lat: f64, lng: f64) -> String {
    let coord = GeographicCoordinate { lat, lng };
    format!("Ferrostar Coordinate: lat={}, lng={}", coord.lat, coord.lng)
}

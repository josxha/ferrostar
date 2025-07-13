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

#[frb::bridge]
mod ffi {
    extern "Rust" {
        type NavigationController;

        #[constructor]
        fn new_navigation_controller() -> NavigationController;

        // define other functions as needed
    }
}

// Implement the methods
pub fn new_navigation_controller() -> NavigationController {
    NavigationController::new()  // or appropriate initializer
}

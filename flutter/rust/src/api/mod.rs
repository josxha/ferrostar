pub mod models;
pub mod navigation;
pub mod routing;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
	// Sets up default panic hook/logging for FRB. Customize if needed.
	flutter_rust_bridge::setup_default_user_utils();
}

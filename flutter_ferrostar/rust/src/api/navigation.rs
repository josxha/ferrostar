use crate::api::models::{NavigationControllerConfig, TripState, UserLocation};
use ferrostar::models::Route;
use ferrostar::navigation_controller::{create_navigator, Navigator};
use ferrostar::navigation_controller::models::NavState;
use std::sync::Arc;

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

#[flutter_rust_bridge::frb(opaque)]
pub struct FlutterNavState {
    pub(crate) inner: NavState,
}

impl FlutterNavState {
    pub fn trip_state(&self) -> TripState {
        self.inner.trip_state()
    }
}

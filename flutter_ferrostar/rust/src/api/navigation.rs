use crate::api::models::{FlutterNavigationControllerConfig, FlutterTripState, FlutterUserLocation};
use ferrostar::models::Route;
use ferrostar::navigation_controller::{create_navigator, Navigator};
use ferrostar::navigation_controller::models::NavState;
use std::sync::Arc;

pub struct FlutterNavigationController {
    inner: Arc<dyn Navigator>,
}

impl FlutterNavigationController {
    pub fn new(route: Route, config: FlutterNavigationControllerConfig) -> Self {
        let inner = create_navigator(route, config.into(), false);
        Self { inner }
    }

    pub fn get_initial_state(&self, location: FlutterUserLocation) -> FlutterNavState {
        let state = self.inner.get_initial_state(location.into());
        FlutterNavState { inner: state }
    }

    pub fn advance_to_next_step(&self, state: &FlutterNavState) -> FlutterNavState {
        let new_state = self.inner.advance_to_next_step(state.inner.clone());
        FlutterNavState { inner: new_state }
    }

    pub fn update_user_location(&self, location: FlutterUserLocation, state: &FlutterNavState) -> FlutterNavState {
        let new_state = self.inner.update_user_location(location.into(), state.inner.clone());
        FlutterNavState { inner: new_state }
    }
}

#[flutter_rust_bridge::frb(opaque)]
pub struct FlutterNavState {
    pub(crate) inner: NavState,
}

impl FlutterNavState {
    pub fn trip_state(&self) -> FlutterTripState {
        self.inner.trip_state().into()
    }
}

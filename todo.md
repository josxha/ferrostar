# Ferrostar Public API Binding TODO

Tracking coverage of the Rust public API with Dart/FRB bindings. Check items as bindings are added (or confirmed existing) in `common/flutter-rust-bridge/src/lib.rs`.

- [ ] Core models
  - [x] `GeographicCoordinate`
  - [x] `Waypoint`, `WaypointKind`, `Route`
  - [x] `UserLocation`, `CourseOverGround`, `Speed`
  - [x] `TripState`, `NavigationControllerConfig`
- [ ] Navigation controller
  - [x] `create_navigator` and `Navigator` methods (state transitions, updates)
  - [x] `NavState` exposure helpers (handle-based `trip_state` accessor)
- [ ] Routing adapters
  - [x] `ValhallaHttpRequestGenerator` (options/config)
  - [x] `RouteRequest` / `RouteResponseParser` helpers
  - [x] `OsrmResponseParser`
- [ ] Simulation
  - [x] `LocationBias`, `SimulationError`, `LocationSimulationState`
  - [x] `location_simulation_from_coordinates`
  - [x] `location_simulation_from_route`
  - [x] `location_simulation_from_polyline`
  - [x] `advance_location_simulation`
- [ ] Algorithms & utilities
  - [ ] Polyline helpers, snapping, truncation utilities
- [ ] Misc FRB convenience
  - [x] Dart-friendly constructors/helpers (e.g., `make_geographic_coordinate`, `route_geometry`)

Notes:
- Keep bindings as thin as possible; prefer 1:1 mappings to the Rust API.
- When wrappers are unavoidable (e.g., to adapt types for FRB), mirror the Rust names and shapes closely.
- Integration tests currently run from flutter/example/integration_test because the package root lacks a Windows runner.

Integration test coverage (bindings):
- [x] Coordinate helpers (`make_geographic_coordinate`, `passthrough_coordinate`, `geographic_coordinate_components`)
- [x] User location helpers (`create_user_location`, `describe_user_location`)
- [x] Simulation happy path (`location_simulation_from_lat_lng`, `advance_location_simulation`)
- [x] Simulation from demo route (`location_simulation_from_demo_route` => `location_simulation_from_route`)
- [x] Valhalla simple request (`generate_valhalla_request_simple`)
- [x] Route geometry helper (`route_geometry` via `demo_route`)
- [x] Navigation controller lifecycle (`demo_navigation_controller`, `trip_state_variant`)
- [ ] Direct Valhalla generator handle (`ValhallaHttpRequestGenerator`) – add test once Dart ctor is exposed
- [ ] Simulation from polyline (`location_simulation_from_polyline`)
- [ ] OSRM/Valhalla response parsing helpers
  - Note: direct Valhalla request path using `createWaypointWithValhallaProperties` currently triggers a DroppableDisposedException on Windows runner; revisit after adjusting handle lifetime.

Next steps to unblock missing tests:
- Add Dart-side builder helpers for `Route`, `RouteStep`, `BoundingBox`, `NavigationControllerConfig`, and `Waypoint` (with `break` kind) to allow constructing navigation/config fixtures from tests.
- Expose a Dart constructor for `ValhallaHttpRequestGenerator` handle shim and add a smoke test that generates a request and asserts headers/body shape.
- Add simple parsing fixtures (serialized OSRM/Valhalla responses) and test `parse_osrm_response` / `RouteResponseParser` helpers.
- Add wrappers to build simulations from `Route` and polyline strings for Dart, then cover `location_simulation_from_route` and `location_simulation_from_polyline`.
- Investigate the DroppableDisposedException in Valhalla GET path (likely handle reuse/disposal); adjust API or test harness to safely cover the request generation.

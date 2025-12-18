// Entry point to run all integration tests together.
import 'package:integration_test/integration_test.dart';

import 'route_selection_button_test.dart' as route_selection;
import 'valhalla_live_navigation_test.dart' as valhalla;

void main() {
  // Ensure integration bindings are in place before delegating to the sub-suites.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  route_selection.main();
  valhalla.main();
}

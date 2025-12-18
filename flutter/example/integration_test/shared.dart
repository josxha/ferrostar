import 'package:flutter_ferrostar/flutter_ferrostar.dart';

Future<void>? _initFuture;

Future<void> ensureRustInitialized() {
  _initFuture ??= RustLib.init();
  return _initFuture!;
}

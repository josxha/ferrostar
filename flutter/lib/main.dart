import 'package:ferrostar/src/rust/models.dart';
import 'package:flutter/material.dart';
import 'package:ferrostar/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = CourseOverGround(degrees: 180);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: Center(
          child: Text(
              'Action: Call Rust `greet("Tom")`\n${model.toString()}'),
        ),
      ),
    );
  }
}

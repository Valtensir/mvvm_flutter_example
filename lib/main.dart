import 'package:flutter/material.dart';
import 'package:mvvm_example/routing/router.dart';
import 'main_staging.dart' as staging;

void main() => staging.main();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: routerConfig(),
    );
  }
}

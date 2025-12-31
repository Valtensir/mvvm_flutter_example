import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:mvvm_example/config/dependencies.dart';
import 'package:mvvm_example/main.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    debugPrint(
      '*****[${event.level}] - [${event.loggerName}] - ${event.message}*****',
    );
    if (event.stackTrace != null) {
      debugPrint('${event.error}');
      debugPrint('${event.stackTrace}');
    }
  });
  runApp(MultiProvider(providers: remoteProviders, child: const MyApp()));
}

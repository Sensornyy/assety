import 'package:assety/app.dart';
import 'package:assety/core/di/init_di.config.dart';
import 'package:assety/core/di/init_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await initDI();

  runApp(App());
}

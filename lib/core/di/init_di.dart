import 'package:assety/core/di/init_di.config.dart';
import 'package:assety/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> initDI() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await locator.init();
}

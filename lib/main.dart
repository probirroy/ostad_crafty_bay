import 'package:ostad_crafty_bay/application/app.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/theme_mode_controller.dart';
import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final themeModeController = ThemeModeController();
//   await themeModeController.initializeThemeMode();
//
//   runApp(CraftyBay());
// }
//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeModeController = ThemeModeController();
  await themeModeController.initializeThemeMode();

  runApp(CraftyBay());
}

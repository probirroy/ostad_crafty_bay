import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController{
  ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);
  void changeThemeMode(ThemeMode mode){
    themeMode.value = mode;

  }
  void toggleThemeMode(){
    if(themeMode.value == ThemeMode.light){
      themeMode.value = ThemeMode.dark;
    }else{
      themeMode.value = ThemeMode.light;
    }

  }
  void saveCurrentThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.value.index);
  }
  Future<ThemeMode> loadSavedThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int themeModeIndex = prefs.getInt('themeMode') ?? 0;
    return ThemeMode.values[themeModeIndex];
  }
  Future<void> initializeThemeMode() async {
    ThemeMode savedThemeMode = await loadSavedThemeMode();
    themeMode.value = savedThemeMode;
  }
  // void initializeThemeMode() async {
  //   ThemeMode savedThemeMode = await loadSavedThemeMode();
  //   themeMode.value = savedThemeMode;
  // }

}

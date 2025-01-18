import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_app_constants.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeLoadEvent>(_loadTheme);
    on<ThemeToggleEvent>(_toggleTheme);
  }

  Future<void> _loadTheme(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isDarkMode = prefs.getBool(MyAppConstants.isDarkThemeKey) ?? true;
    if (isDarkMode) {
      emit(ThemeDarkState(themeData: MyThemeData.darkTheme));
    } else {
      emit(ThemeLightState(themeData: MyThemeData.lightTheme));
    }
  }

  Future<void> _toggleTheme(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = state;
    if (currentState is ThemeLightState) {
      emit(ThemeDarkState(themeData: MyThemeData.darkTheme));
      await prefs.setBool(MyAppConstants.isDarkThemeKey, true);
    } else {
      emit(ThemeLightState(themeData: MyThemeData.lightTheme));
      await prefs.setBool(MyAppConstants.isDarkThemeKey, false);
    }
  }
}

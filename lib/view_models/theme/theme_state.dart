part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeLightState extends ThemeState {
  final ThemeData themeData;
  ThemeLightState({required this.themeData});
}

final class ThemeDarkState extends ThemeState {
  final ThemeData themeData;
  ThemeDarkState({required this.themeData});
}

final class ThemeError extends ThemeState {}



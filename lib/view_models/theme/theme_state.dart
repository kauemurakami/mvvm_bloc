part of 'theme_bloc.dart';

@immutable
sealed class ThemeState extends Equatable {
  const ThemeState();
  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

final class ThemeLightState extends ThemeState {
  final ThemeData themeData;
  const ThemeLightState({required this.themeData});
  @override
  List<Object> get props => [themeData];
}

final class ThemeDarkState extends ThemeState {
  final ThemeData themeData;
  const ThemeDarkState({required this.themeData});
  @override
  List<Object> get props => [themeData];
}

final class ThemeError extends ThemeState {}

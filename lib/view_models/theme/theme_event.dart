part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ThemeToggleEvent extends ThemeEvent {}

class ThemeLoadEvent extends ThemeEvent {}

part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  ThemeMode getTheme() {
    if (this is DarkThemeState) return ThemeMode.dark;
    return ThemeMode.light;
  }
}

class LightThemeState extends ThemeState {}

class DarkThemeState extends ThemeState {}

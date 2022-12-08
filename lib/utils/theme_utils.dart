import 'package:flutter/material.dart';
import 'package:pr5/cubit/theme_cubit.dart';

extension ThemeExtensions on ThemeMode {
  ThemeState getThemeState() {
    switch (this) {
      case ThemeMode.system:
        return LightThemeState();
      case ThemeMode.light:
        return LightThemeState();
      case ThemeMode.dark:
        return DarkThemeState();
    }
  }
}

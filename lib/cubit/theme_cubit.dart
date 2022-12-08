// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pr5/utils/theme_utils.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeMode _theme = ThemeMode.light;

  ThemeMode get theme => _theme;

  ThemeCubit({required ThemeMode type}) : super(type.getThemeState()) {
    _theme = type;
  }

  ThemeMode toggleTheme() {
    if (_theme == ThemeMode.light) {
      _theme = ThemeMode.dark;
      emit(DarkThemeState());
    } else {
      _theme = ThemeMode.light;
      emit(LightThemeState());
    }
    return _theme;
  }
}

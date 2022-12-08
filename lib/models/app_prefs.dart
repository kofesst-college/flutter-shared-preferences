import 'package:flutter/material.dart';
import 'package:pr5/constants.dart';

class AppPrefs {
  final ThemeMode theme;
  final String? text;

  AppPrefs({required this.theme, this.text});

  String getInitialRoute() {
    return text != null
        ? AppConstants.detailsPageRoute
        : AppConstants.inputPageRoute;
  }
}

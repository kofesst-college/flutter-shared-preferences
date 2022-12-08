import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr5/constants.dart';
import 'package:pr5/cubit/theme_cubit.dart';
import 'package:pr5/models/app_prefs.dart';
import 'package:pr5/pages/details_page.dart';
import 'package:pr5/pages/input_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<AppPrefs> _restoreAppPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(AppConstants.textPreferencesKey);
    final theme = ThemeMode.values.elementAt(
      prefs.getInt(AppConstants.themePreferencesKey) ?? 0,
    );
    return AppPrefs(theme: theme, text: text);
  }

  void _saveTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(AppConstants.themePreferencesKey, theme.index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _restoreAppPrefs(),
      builder: (context, prefsSnapshot) {
        if (prefsSnapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final appPrefs = prefsSnapshot.data!;
        return BlocProvider(
          create: (context) => ThemeCubit(type: appPrefs.theme),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'PR5',
                themeMode: state.getTheme(),
                theme: ThemeData(primarySwatch: Colors.blue),
                darkTheme: ThemeData(
                  primarySwatch: Colors.blue,
                  colorScheme: const ColorScheme.dark(),
                ),
                builder: (context, navigator) {
                  return Overlay(
                    initialEntries: [
                      OverlayEntry(builder: (context) {
                        return Scaffold(
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {
                              _saveTheme(
                                context.read<ThemeCubit>().toggleTheme(),
                              );
                            },
                            tooltip: 'Переключить тему',
                            child: const Icon(Icons.add),
                          ),
                          body: SafeArea(child: navigator!),
                        );
                      }),
                    ],
                  );
                },
                routes: {
                  AppConstants.inputPageRoute: (_) => InputPage(),
                  AppConstants.detailsPageRoute: (_) => const DetailsPage(),
                },
                initialRoute: appPrefs.getInitialRoute(),
              );
            },
          ),
        );
      },
    );
  }
}

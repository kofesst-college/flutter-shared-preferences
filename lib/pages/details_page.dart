import 'package:flutter/material.dart';
import 'package:pr5/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  Future<String?> _restoreText() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.textPreferencesKey);
  }

  Future<void> _clearInput() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.textPreferencesKey);
  }

  @override
  Widget build(BuildContext context) {
    String? text;
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      return FutureBuilder(
        future: _restoreText(),
        builder: (context, textSnapshot) {
          if (textSnapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          text = textSnapshot.data;
          if (text == null) {
            return const Center(
              child: Text('Ошибка'),
            );
          }

          return _textDetails(context, text!);
        },
      );
    }

    text = args as String;
    return _textDetails(context, text);
  }

  Widget _textDetails(BuildContext context, String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Текст: "$text"'),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _clearInput().then((_) {
                Navigator.pushReplacementNamed(
                  context,
                  AppConstants.inputPageRoute,
                );
              });
            },
            child: const Text('Очистить'),
          ),
        ],
      ),
    );
  }
}

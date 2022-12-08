import 'package:flutter/material.dart';
import 'package:pr5/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatelessWidget {
  final _inputController = TextEditingController();

  InputPage({Key? key}) : super(key: key);

  Future<String> _onInputSave() async {
    final text = _inputController.value.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.textPreferencesKey, text);
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _inputController,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _onInputSave().then((text) {
                Navigator.pushReplacementNamed(
                  context,
                    AppConstants.detailsPageRoute,
                  arguments: text
                );
              });
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}

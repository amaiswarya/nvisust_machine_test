import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences _preferences;
  static SharedPref? sharedPref;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    sharedPref = this;
    return;
  }

  static SharedPref? getInstance() {
    return sharedPref;
  }

  //Set string to shared preferance
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

//Set bool to shared preferance
  Future<void> setBool({required String key, required bool value}) async {
    await _preferences.setBool(key, value);
  }

  //Get string from shared preferance
  String getString(String key) => _preferences.getString(key) ?? '';

//Get bool from shared preferance
  bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }
}

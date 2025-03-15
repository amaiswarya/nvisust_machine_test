import 'package:nvisust_test/src/config/preference_config/preference_config.dart';
import 'package:nvisust_test/src/core/utils/shared_utils/shared_keys.dart';

class SharedUtils extends SharedPref {
  ///Set user UUID
  static Future<void> setUUID(String value) async {
    await SharedPref.getInstance()!.setString(SharedKeys.uuid, value);
  }

  ///Get UUID from shared preferance
  static String get getUUID =>
      SharedPref.getInstance()!.getString(SharedKeys.uuid);
}

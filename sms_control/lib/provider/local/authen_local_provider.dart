import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_control/configs/shared_preferences_keys.dart';

class AuthenLocalProvider {
  Future<String?> getTokenFromLocal() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final response = sharedPrefs.getString(SharedPrefsKeys.token);

    return response;
  }

  Future<bool> saveTokenToLocal(String token) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setString(SharedPrefsKeys.token, token);
  }

  Future<bool> removeTokenFromLocal() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.remove(SharedPrefsKeys.token);
  }
}

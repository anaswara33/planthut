import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static Future<String> getUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final String userId = sharedPrefs.getString("userId");
    return userId;
  }

  static Future<void> setUserId(String userId) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString("userId", userId);
  }

  static Future<void> clear() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
  }
}

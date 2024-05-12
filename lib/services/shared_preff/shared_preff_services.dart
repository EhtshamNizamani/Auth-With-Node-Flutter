import 'package:shared_preferences/shared_preferences.dart';

class SharePreServices {
  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('accessToken', accessToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('accessToken');
  }
}

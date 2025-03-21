import 'package:shared_preferences/shared_preferences.dart';

class HigecoSharedPreferences {
  static late SharedPreferences _preferences;
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setAuthToken(String token) async => await _preferences.setString('auth_token', token);
  static String? getAuthToken() => _preferences.getString('auth_token');
}
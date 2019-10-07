import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHandler {
  static String _isLogin = "isLogin";
  static String _currentUser = "currentUser";

  static Future<bool> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool(_isLogin) ?? false;
    return isLogin;
  }

  static saveLoginState(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLogin, isLogin);
  }

  static Future<void> saveCurrentUser(String objectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_currentUser, objectId);
  }

  static Future<String> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUser);
  }

}

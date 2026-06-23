import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesHelper {
  SharePreferencesHelper();

  SharePreferencesHelper._();

  static final SharePreferencesHelper instance = SharePreferencesHelper._();
  static const String _keyName = 'name';

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
  }

  Future<String> readName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName) ?? '';
  }
}

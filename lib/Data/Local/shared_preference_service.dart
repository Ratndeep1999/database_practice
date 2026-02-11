import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  /// Singleton pattern
  static final SharedPreferenceService _instance =
      SharedPreferenceService.internal();

  SharedPreferenceService.internal();

  factory SharedPreferenceService() => _instance;

  /// SharedPreference object get
  static SharedPreferences? _prefs;

  Future<SharedPreferences> get _sharedPrefs async {
    return _prefs ??= await SharedPreferences.getInstance();
  }

  static const String _kIsLoggedIn = "isLoggedIn";

  /// Check login status
  Future<bool> get getLoginStatus async {
    final prefs = await _sharedPrefs;
    return prefs.getBool(_kIsLoggedIn) ?? false;
  }

  /// Set login value
  Future<void> setLoginValue() async {
    final prefs = await _sharedPrefs;
    prefs.setBool(_kIsLoggedIn, true);
  }

  /// Clear all stored values
  Future<void> clearAll() async {
    final prefs = await _sharedPrefs;
    await prefs.clear();
  }
}

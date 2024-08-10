import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'social_login.dart';

class SP {
  static final i = SP();
  SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setString({required String key, required String value}) async {
    await _sharedPreferences?.setString(key, value);
  }

  Future<void> setBool({required String key, required bool value}) async {
    await _sharedPreferences?.setBool(key, value);
  }

  String? getString({required String key}) {
    return _sharedPreferences?.getString(key);
  }

  bool getBool({required String key}) {
    return _sharedPreferences?.getBool(key) ?? false;
  }

  void signOut() async {
    _sharedPreferences?.clear();
    SocialLogin.shared.googleSignOut();
    AppNavigator.shared.pushNamedAndRemove(routeName: Routes.login);
  }
}

import 'dart:convert';

import 'package:resto_radar/data/models/restaurant_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<bool> saveAuthData(Restaurant model) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final res = await pref.setString('auth', jsonEncode(model.toJson()));
    return res;
  }

  Future<String> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';
    final authData = Restaurant.fromJson(jsonDecode(authJson));
    return authData.id;
  }
}

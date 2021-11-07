import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SallerDetailProvider {
  late SharedPreferences _sharedPreferences;

  //constructor
  SallerDetailProvider(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  String get email => _sharedPreferences.getString(Email) ?? "";

  String get userId => _sharedPreferences.getString(Id) ?? "";

  String get userName => _sharedPreferences.getString(Username) ?? "";

  String get mobile => _sharedPreferences.getString(Mobile) ?? "";

  String get profileUrl => _sharedPreferences.getString(IMage) ?? "";

  Future<void> saveUserDetail(
      String userId,
      String? name,
      String? email,
      String? mobile,
      String? city,
      String? area,
      String? address,
      String? pincode,
      String? latitude,
      String? longitude,
      String? image,
      BuildContext context) async {
    final waitList = <Future<void>>[];

    waitList.add(_sharedPreferences.setString(Id, userId));
    waitList.add(_sharedPreferences.setString(Username, name ?? ""));
    waitList.add(_sharedPreferences.setString(Email, email ?? ""));
    waitList.add(_sharedPreferences.setString(Mobile, mobile ?? ""));
    waitList.add(_sharedPreferences.setString(City, city ?? ""));
    waitList.add(_sharedPreferences.setString(Area, area ?? ""));
    waitList.add(_sharedPreferences.setString(Address, address ?? ""));
    waitList.add(_sharedPreferences.setString(Pincode, pincode ?? ""));
    waitList.add(_sharedPreferences.setString(IMage, image ?? ""));
  }
}

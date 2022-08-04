
import 'package:ecommerce/model/imports/generalImport.dart';

class LocalStorage {
//set String into shared preferences like this
  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value).then((value) {
      if (kDebugMode) {
        print("value from shared preference");
      }
    });
    return true;
  }

//get String value from shared preferences
  static Future<int?> getInt(String? key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int? storage;
    storage = pref.getInt(key!);
    return storage;
  }

//set bool into shared preferences like this
  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value).then((value) {
      if (kDebugMode) {
        print("value from shared preference");
      }
    });
    return true;
  }

//get bool value from shared preferences
  static Future<bool?> getBool(String? key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool? storage;
    storage = pref.getBool(key!);
    return storage;
  }
}
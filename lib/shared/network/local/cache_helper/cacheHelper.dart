import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache_Helper{
  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }
    static SharedPreferences?  sharedPreferences;
 static   Future<bool?> putData(@required String key,@required bool value) async
    {
      print('value is $value');
       return await sharedPreferences?.setBool(key, value);
    }
    static   bool? getData(@required String key)
    {
      print('value is ${sharedPreferences?.getBool(key)}');
      return sharedPreferences?.getBool(key);
    }


}
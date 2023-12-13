import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DiOHelper{
   static late Dio dio;
   static init(){
      dio=Dio(BaseOptions(
         baseUrl: 'https://newsapi.org/',
         receiveDataWhenStatusError: true
      ));
   }
  static Future<Response> getData(@required String url,@required  Map<String,dynamic> queryParams) async
   {
    return await  dio.get(url,queryParameters: queryParams);
   }
}
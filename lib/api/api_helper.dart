import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_auth_api/api/urls.dart';

mixin ApiHelper{
  final _dio = Dio();

  Future postTypeHelper (String endpoint, dynamic body) async {
    log(body.toJson().toString());
    String url = Urls.baseUrl+endpoint;
    try{
      Response response = await _dio.post(url, data: body.toJson());

      return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
    }catch(error){
      return {"statusCode":40004, "body": null, "errorMsg": error.toString()};
    }
  }

  Future getTypeHelper(String endpoint, dynamic query) async {
    SharedPreferences logInData = await SharedPreferences.getInstance();
    var token = logInData.getString("token");
    log(query.toJson().toString());
    if (kDebugMode) {
      print("Token: $token");
    }
    Map<String, dynamic> myQuery = query.toJson();
    String url = Urls.baseUrl+endpoint;
    try{
      _dio.options.headers["authorization"] = "Authorization $token";
      Response response = await _dio.get(url, queryParameters: myQuery);
      log(response.data.toString());
      return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
    }catch(error){
      return {"statusCode":49004, "body": null, "errorMsg": error.toString()};
    }
  }
}
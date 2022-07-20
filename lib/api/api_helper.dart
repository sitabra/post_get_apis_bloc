import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:testing_auth_api/api/urls.dart';

mixin ApiHelper{
  final _dio = Dio();

  Future postTypeHelper (String endpoint, dynamic body) async {
    log(body.toJson().toString());
    String url = Urls.baseUrl+endpoint;
    try{
      Response response = await _dio.post(url, data: body.toJson());

      return {"statusCode":response.statusCode, "body": response.data, "errorMsg": null};
    }catch(error, stacktrace){
      return {"statusCode":40004, "body": null, "errorMsg": error.toString()};
    }
  }

  Future getTypeHelper(String endPoint, Map<String, dynamic> query) async {
    var response = await http.get(
      query.isNotEmpty
          ? Uri.http(Urls.baseUrl, endPoint, query)
          : Uri.http(Urls.baseUrl, endPoint),
    );
    if (kDebugMode) {
      log(response.request.toString());
    }
  }
}
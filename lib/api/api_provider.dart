import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:testing_auth_api/api/api_helper.dart';
import 'package:testing_auth_api/api/urls.dart';
import 'package:testing_auth_api/screens/home_page_screen/model/user_model.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/request_model.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/response_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/request_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/response_model.dart';

import '../screens/home_page_screen/model/user_request_modal.dart';
import '../screens/profile_screen/models/user_details_response_model.dart';
import '../screens/profile_screen/models/user_details_request_model.dart';

class ApiProvider with ApiHelper{

  Future<LogInResponseModel?> logInApi(LogInRequestModel loginRequest) async{
    var resp = await postTypeHelper(Urls.loginUrl, loginRequest);
    if(resp.containsKey("statusCode")){
      if(resp["statusCode"]==200){
        return LogInResponseModel.fromJson(resp["body"]);
      }else if(resp["statusCode"]==49004){
        log("Exception Occurred: ${resp["errorMsg"]}");
        return LogInResponseModel.withError("You are offline. PLease check your internet connection");
      }else{
        throw Exception("Something went wrong");
      }
    }
    return null;
  }

  Future<RegistrationResponseModel?> signUpApi(RegistrationRequestModel requestSignIn) async{
    var resp = await postTypeHelper(Urls.registrationUrl, requestSignIn);
    if(resp.containsKey("statusCode")){
      if(resp["statusCode"]==200){
        return RegistrationResponseModel.fromJson(resp["body"]);
      }else if(resp["statusCode"]==49004){
        log("Exception Occurred: ${resp["errorMsg"]}");
        return RegistrationResponseModel.withError("You are offline. PLease check your internet connection");
      }else{
        throw Exception("Something went wrong");
      }
    }
    return null;
  }

  Future<UserResponseModel> fetchUserDetails(UserRequestModelPageWise requestModelPageWise) async {
    final response = await getTypeHelper(Urls.usersUrl, requestModelPageWise);
    if (response["statusCode"] == 200) {
      return UserResponseModel.fromJson(response["body"]);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<UserDetailsResponseModel> fetchUserDetailsOnProfile(UserDetailsRequestModelIdWise requestModelIdWise) async {
    final response = await getTypeHelper(Urls.usersDetailsUrl, requestModelIdWise);
    log(response.toString());
    if (kDebugMode) {
      print("I am here");
    }
    if (response["statusCode"] == 200) {
      if (kDebugMode) {

      }return UserDetailsResponseModel.fromJson(response["body"]);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

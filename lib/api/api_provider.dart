import 'dart:developer';

import 'package:testing_auth_api/api/api_helper.dart';
import 'package:testing_auth_api/api/urls.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/request_model.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/response_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/request_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/response_model.dart';

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
}
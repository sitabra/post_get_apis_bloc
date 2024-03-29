import 'package:testing_auth_api/api/api_provider.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/log_in_request_model.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/log_in_response_model.dart';

class LogInRepository{
  final apiProvider = ApiProvider();

  Future<LogInResponseModel?> logInUser(LogInRequestModel requestLogIn) {
    return apiProvider.logInApi(requestLogIn);
  }
}
class NetworkError extends Error {}
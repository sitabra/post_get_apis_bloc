import 'package:testing_auth_api/api/api_provider.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/sign_up_request_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/sign_up_response_model.dart';

class RegistrationRepository{
final apiProvider = ApiProvider();

Future<RegistrationResponseModel?> signInUser(RegistrationRequestModel requestSignIn) {
  return apiProvider.signUpApi(requestSignIn);
  }
}
class NetworkError extends Error {}
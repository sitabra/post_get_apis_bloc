import '../../../api/api_provider.dart';
import '../model/user_response_model.dart';
import '../model/user_request_modal.dart';

class UserRepository{
  final apiProvider = ApiProvider();

  Future<UserResponseModel?> userRequest(UserRequestModelPageWise requestUser) {
    return apiProvider.fetchUserDetails(requestUser);
  }
}
class NetworkError extends Error {}
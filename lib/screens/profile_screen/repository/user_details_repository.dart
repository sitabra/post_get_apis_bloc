import '../../../api/api_provider.dart';
import '../models/user_details_response_model.dart';
import '../models/user_details_request_model.dart';

class UserDetailsRepository{
  final apiProvider = ApiProvider();

  Future<UserDetailsResponseModel?> userDetailsRequest(UserDetailsRequestModelIdWise requestUserDetails) {
    return apiProvider.fetchUserDetailsOnProfile(requestUserDetails);
  }
}
class NetworkError extends Error {}
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_details_response_model.dart';
import '../models/user_details_request_model.dart';
import '../repository/user_details_repository.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc(UserDetailsRepository userDetailsRepository) : super(UserDetailsStateInitial()) {
    final UserDetailsRepository repository = UserDetailsRepository();
    on<UserDetailsEvent>((event, emit) async {
      UserDetailsRequestModelIdWise requestUserDetails = UserDetailsRequestModelIdWise(event.id);
      try{
        emit(UserDetailsStateLoading());
        final userDetails = await repository.userDetailsRequest(requestUserDetails);
        if(userDetails!.location!=null){
          emit(UserDetailsStateLoaded(userDetails));
        }else{
          emit(const UserDetailsStateError("Unable to load data or no data found"));
        }
      } on NetworkError{
        emit(const UserDetailsStateError("No Internet Connection"));
      }
    });
  }
}
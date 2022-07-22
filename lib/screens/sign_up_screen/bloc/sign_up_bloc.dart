import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/request_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/model/response_model.dart';
import 'package:testing_auth_api/screens/sign_up_screen/repository/registration_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(RegistrationRepository registrationRepository) : super(SignUpStateInitial()) {
    final RegistrationRepository repository = RegistrationRepository();
    on<SignUpEvent>((event, emit) async {
      RegistrationRequestModel requestModel = RegistrationRequestModel(event.name,event.email ,event.password);

      try{
        emit(SignUpStateLoading());
        final userList = await repository.signInUser(requestModel);
        if(userList!.code==0){
          emit(SignUpStateLoaded(userList));
        }else if(userList.code == 1){
          if(userList.message != null){
            emit(SignUpStateError(userList.message));
          }
        }else if(userList.code == null){
          if(userList.message != null){
            emit(SignUpStateError(userList.message));
          }
        }
      } on NetworkError{
        emit(const SignUpStateError("No Internet Connection"));
      }
    });
  }
}


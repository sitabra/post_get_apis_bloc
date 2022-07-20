import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/request_model.dart';
import 'package:testing_auth_api/screens/log_in_screen/models/response_model.dart';
import 'package:testing_auth_api/screens/log_in_screen/repository/log_in_repository.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc(LogInRepository logInRepository) : super(LogInStateInitial()) {
    final LogInRepository repository = LogInRepository();
    on<LogInEvent>((event, emit) async {
      LogInRequestModel requestModel = LogInRequestModel(event.email, event.password);

      try{
        emit(LogInStateLoading());
        final myList = await repository.logInUser(requestModel);
        if(myList!.code==0){
          emit(LogInStateLoaded(myList));
        }else if(myList.code == 1){
          if(myList.message != null){
            emit(LogInStateError(myList.message));
          }
        }else if(myList.code == null){
          if(myList.message != null){
            emit(LogInStateError(myList.message));
          }
        }
      } on NetworkError{
        emit(const LogInStateError("No Internet Connection"));
      }
    });
  }
}

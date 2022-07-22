import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import '../model/user_request_modal.dart';
import '../repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(UserRepository userRepository) : super(UserStateInitial()) {
    final UserRepository repository = UserRepository();
    on<UserEvent>((event, emit) async {
      UserRequestModelPageWise requestModel = UserRequestModelPageWise(event.page);
      try{
        emit(UserStateLoading());
        final myList = await repository.userRequest(requestModel);
        if(myList!.data!=null){
          emit(UserStateLoaded(myList));
        }else{
            emit(const UserStateError("Unable to load data or no data found"));
        }
      } on NetworkError{
        emit(const UserStateError("No Internet Connection"));
      }
    });
  }
}

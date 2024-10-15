import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/core/di/init_di.dart';
import 'package:assety/features/user/domain/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = locator.get<UserRepository>();
  User? user;

  UserBloc() : super(UserInitial()) {
    on<UserEvent>(_onUserEvent);
  }

  Future<void> _onUserEvent(
    UserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());

    final Result result;

    if (event is GetUser) {
      result = await _userRepository.getUser();

      user = result.data;
    } else if (event is UpdateUser) {
      result = await _userRepository.updateUser(
        displayName: event.displayName,
        photoUrl: event.photoUrl,
      );
    } else if (event is DeleteUser) {
      result = await _userRepository.deleteUser();
    } else {
      return;
    }

    if (user == null) {
      return emit(UserFailure());
    }

    result.when(
      failure: (_) => emit(UserFailure()),
      success: () => emit(UserSuccess(user!)),
      successWithData: (_) => emit(UserSuccess(user!)),
    );
  }
}

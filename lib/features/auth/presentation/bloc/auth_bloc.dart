import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/core/di/init_di.dart';
import 'package:assety/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = locator.get<AuthRepository>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(_onAuthEvent);
  }

  Future<void> _onAuthEvent(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    Result result;

    if (event is SignUpWithEmailAndPassword) {
      result = await _repository.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // if (result.isError) {
      //   result = await _repository.signInWithEmailAndPassword(
      //     email: event.email,
      //     password: event.password,
      //   );
      // }
    } else if (event is SignInWithEmailAndPassword) {
      result = await _repository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
    } else if (event is SignInWithGoogle) {
      result = await _repository.signInWithGoogle();
    } else if (event is SignInWithApple) {
      result = await _repository.signInWithApple();
    } else if (event is SignOut) {
      result = await _repository.signOut();
      if (result.isError) {
        emit(AuthFailure());
      } else {
        emit(
          AuthSuccess(
            shouldSignOut: true,
          ),
        );
      }
      return;
    } else {
      return;
    }

    result.when(
      failure: (_) => emit(AuthFailure()),
      success: () => emit(AuthSuccess()),
    );
  }
}

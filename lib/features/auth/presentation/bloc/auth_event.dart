part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}

final class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}

final class SignInWithGoogle extends AuthEvent {}

final class SignInWithApple extends AuthEvent {}

final class SignOut extends AuthEvent {}

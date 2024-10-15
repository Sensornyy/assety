import 'package:assety/core/data/error_handler/result.dart';

abstract interface class AuthRepository {
  Future<Result> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Result> signInWithGoogle();

  Future<Result> signInWithApple();

  Future<Result> signOut();
}

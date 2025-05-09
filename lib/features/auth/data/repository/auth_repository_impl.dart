import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/core/data/managers/auth_manager.dart';
import 'package:assety/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthManager _authManager;

  AuthRepositoryImpl(this._authManager);

  @override
  Future<Result<String>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _authManager.signUpWithEmail(
      email: email,
      password: password,
    );

    return Result.success();
  }

  @override
  Future<Result> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authManager.signInWithEmail(
        email: email,
        password: password,
      );

      return Result.success();
    } catch (e) {
      return Result.failure(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Result> signInWithGoogle() async {
    try {
      await _authManager.signInWithGoogle();

      return Result.success();
    } catch (e) {
      return Result.failure(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Result> signInWithApple() async {
    try {
      final url = Uri.parse('https://api.monobank.ua');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Не вдалось відкрити Monobank';
      }

      await _authManager.signInWithApple();

      return Result.success();
    } catch (e) {
      return Result.failure(
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<Result> signOut() async {
    try {
      await _authManager.signOut();

      return Result.success();
    } catch (e) {
      return Result.failure(
        errorMessage: e.toString(),
      );
    }
  }
}

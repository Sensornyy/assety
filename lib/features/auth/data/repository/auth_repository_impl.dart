import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/core/data/managers/auth_manager.dart';
import 'package:assety/core/data/managers/dio_manager.dart';
import 'package:assety/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthManager _authManager;
  final DioManager _dioManager;

  AuthRepositoryImpl(this._authManager, this._dioManager,);

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
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);

      final req = await _dioManager.dio.get('https://api.monobank.ua');
      print(req);
      // await _authManager.signInWithApple();

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

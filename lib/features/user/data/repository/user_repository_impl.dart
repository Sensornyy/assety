import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/core/data/managers/auth_manager.dart';
import 'package:assety/core/data/managers/user_manager.dart';
import 'package:assety/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserManager _userManager;
  final AuthManager _authManager;

  UserRepositoryImpl(
    this._userManager,
    this._authManager,
  );

  @override
  Future<Result> getUser() async {
    try {
      final user = await _userManager.getUser();

      return Result.successWithData(user);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result> updateUser({String? displayName, String? photoUrl}) async {
    try {
      await _userManager.updateUser(
        displayName: displayName,
        photoUrl: photoUrl,
      );

      return Result.success();
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result> deleteUser() async {
    try {
      await _authManager.signOut();
      await _userManager.deleteUser();

      return Result.success();
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}

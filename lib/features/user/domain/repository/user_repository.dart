import 'package:assety/core/data/error_handler/result.dart';

abstract interface class UserRepository {
  Future<Result> getUser();

  Future<Result> updateUser({
    String? displayName,
    String? photoUrl,
  });

  Future<Result> deleteUser();
}

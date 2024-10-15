import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserManager {
  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser!;
  }

  Future<void> updateUser({String? displayName, String? photoUrl}) async {
    final user = await getUser();

    await user.updateProfile(
      displayName: displayName,
      photoURL: photoUrl,
    );
  }

  Future<void> deleteUser() async {
    final user = await getUser();

    await user.delete();
  }
}

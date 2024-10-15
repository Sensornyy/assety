part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUser extends UserEvent {}

final class UpdateUser extends UserEvent {
  final String? displayName;
  final String? photoUrl;

  UpdateUser({
    this.displayName,
    this.photoUrl,
  });
}

final class DeleteUser extends UserEvent {}

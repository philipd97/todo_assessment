part of 'user_bloc.dart';

abstract class UserEvent {
  const UserEvent();
}

class InputUsernameEvent extends UserEvent {
  final String username;

  const InputUsernameEvent({required this.username});
}

class FetchUsernameEvent extends UserEvent {
  const FetchUsernameEvent();
}

class FinishShowCaseEvent extends UserEvent {
  final bool watchedShowcase;

  const FinishShowCaseEvent({required this.watchedShowcase});
}

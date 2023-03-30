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

class FinishFirstTimeShowcaseEvent extends UserEvent {
  const FinishFirstTimeShowcaseEvent();
}

class WatchShowcaseEvent extends UserEvent {
  const WatchShowcaseEvent();
}

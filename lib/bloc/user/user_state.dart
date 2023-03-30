part of 'user_bloc.dart';

class UserState implements Loader {
  static const userTable = 'user';
  static const usernameKey = 'username';
  static const watchedShowcaseKey = 'watchedShowcase';

  final String? username;
  final bool watchedShowcase;

  @override
  final bool isLoading;

  const UserState({
    this.username,
    this.isLoading = false,
    this.watchedShowcase = false,
  });

  UserState.init()
      : username = null,
        isLoading = false,
        watchedShowcase = false;

  UserState copyWith({
    String? username,
    bool? isLoading,
    bool? watchedShowcase,
  }) {
    return UserState(
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      watchedShowcase: watchedShowcase ?? this.watchedShowcase,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      UserState.usernameKey: username,
      UserState.watchedShowcaseKey: watchedShowcase ? 1 : 0,
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      username: map[UserState.usernameKey],
      watchedShowcase:
          (map[UserState.watchedShowcaseKey] as int) == 1 ? true : false,
    );
  }
}

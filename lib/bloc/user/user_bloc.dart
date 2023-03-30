import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assessment/helpers/database_helper.dart';
import 'package:todo_assessment/model/loader.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final DatabaseHelper databaseHelper;

  UserBloc(this.databaseHelper) : super(UserState.init()) {
    on<FetchUsernameEvent>(_onFetchUserEventName);
    on<InputUsernameEvent>(_onInputUsernameEvent);
    on<FinishFirstTimeShowcaseEvent>(_onFinishShowCaseEvent);
    on<WatchShowcaseEvent>(_onWatchShowcaseEvent);
  }

  void _onFetchUserEventName(FetchUsernameEvent event, Emitter emit) async {
    emit(const UserState(isLoading: true));

    // check if username exists in database
    final database = await databaseHelper.database;
    final list = await database.query(UserState.userTable);

    if (list.isEmpty) {
      emit(const UserState(isLoading: false));
      return;
    }

    final newState = list.map((e) => UserState.fromMap(e)).first;

    emit(newState.copyWith(isLoading: false));
  }

  void _onInputUsernameEvent(InputUsernameEvent event, Emitter emit) async {
    try {
      emit(const UserState(isLoading: true));

      final userState = state.copyWith(
          username: event.username, watchedShowcase: false, isLoading: false);

      // add username in db
      final database = await databaseHelper.database;
      await database.insert(
        UserState.userTable,
        userState.toMap(),
      );

      emit(userState);
    } catch (e) {}
  }

  void _onFinishShowCaseEvent(
      FinishFirstTimeShowcaseEvent event, Emitter emit) async {
    log('UserState: $state');
    final newState = state.copyWith(watchedShowcase: true);
    // add username in db
    final database = await databaseHelper.database;
    await database.update(
      UserState.userTable,
      newState.toMap(),
    );
    emit(newState);
    log('newUserState: $state');
  }

  void _onWatchShowcaseEvent(WatchShowcaseEvent event, Emitter emit) =>
      emit(state.copyWith(watchedShowcase: false));
}

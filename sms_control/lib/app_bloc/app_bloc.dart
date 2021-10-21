import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sms_control/app_bloc/bloc.dart';
import 'package:sms_control/provider/local/authen_local_provider.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenLocalProvider authenLocalProvider;

  AppBloc(this.authenLocalProvider) : super(AppUninitialized());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppStarted) {
      // final token = await authenLocalProvider.getTokenFromLocal();
      final token = null;

      if (token != null) {
        yield AppAuthenticated();
      } else {
        yield AppUnauthenticated();
      }
    } else if (event is LoggedIn) {
      final result =
          await authenLocalProvider.saveTokenToLocal('this_is_token');
      yield AppAuthenticated();
    } else if (event is LogOuted) {
      yield AppLoading();
      final result =
      await authenLocalProvider.removeTokenFromLocal();
      yield HideAppLoading();
      yield AppUnauthenticated();
    }
  }
}

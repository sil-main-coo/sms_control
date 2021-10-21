import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sms_control/app_bloc/bloc.dart';
import 'package:sms_control/login/bloc/bloc.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppBloc appBloc;

  LoginBloc({required this.appBloc}): super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        if(event.account.useName == 'admin' && event.account.password == 'admin'){
          final token ='day la token nha'; // -> lưu token
          appBloc.add(LoggedIn(token: token));
          yield HiddenLoginLoading();
          yield LoginInitial();
        }else{
          yield HiddenLoginLoading();
          yield LoginFailure(
            error: 'Sai thông tin tài khoản'
          );
        }
      } catch (error) {
        yield HiddenLoginLoading();
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
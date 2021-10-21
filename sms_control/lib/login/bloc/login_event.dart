import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sms_control/models/account.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final Account account;

  const LoginButtonPressed({
    required this.account,
  });

  @override
  List<Object> get props => [account];

  @override
  String toString() =>
      'LoginButtonPressed { username: ${account.useName}, password: ${account.password} }';
}

class Logout extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
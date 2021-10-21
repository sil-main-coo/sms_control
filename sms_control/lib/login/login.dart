
import 'package:sms_control/app_bloc/app_bloc.dart';
import 'package:sms_control/views/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'children/bg_header.dart';
import 'children/input_box.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          bgHeaderLogin(),
          BlocProvider(
            create: (context) {
              return LoginBloc(appBloc: BlocProvider.of<AppBloc>(context));
            },
            child: BoxInputLogin(),
          ),
        ],
      ),
    );
  }
}

import 'package:sms_control/configs/values/values.dart';
import 'package:sms_control/models/account.dart';
import 'package:sms_control/views/login/bloc/bloc.dart';
import 'package:sms_control/views/widgets/app_textfield.dart';
import 'package:sms_control/views/widgets/dialogs/dialogs.dart';
import 'package:sms_control/views/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxInputLogin extends StatefulWidget {
  @override
  _BoxInputLoginState createState() => _BoxInputLoginState();
}

class _BoxInputLoginState extends State<BoxInputLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
            account: Account(
              _usernameController.text.trim(),
              _passwordController.text.trim(),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginLoading) {
        LoadingDialog.show(context, 'Đang đăng nhập...');
      } else if (state is LoginFailure) {
        AppDialog.showNotifyDialog(context: context,
            mess: state.error,
            textBtn: 'OK',
            function: () => Navigator.pop(context),
            color: secondary);
      }else if(state is HiddenLoginLoading){
        LoadingDialog.hide(context);
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil().setHeight(80),
                ),
                Text(
                  'ĐĂNG NHẬP',
                  style: Theme
                      .of(context)
                      .primaryTextTheme
                      .headline!
                      .copyWith(fontSize: 26.sp),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(60),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(350),
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AppTextField.tfOnBody(context, _usernameController, 'Tài khoản',
                              TextInputAction.next, true),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          AppTextField.tfOnBody(context, _passwordController, 'Mật khẩu',
                              TextInputAction.done, false,
                              obscureText: true),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                SizedBox(
                    height: ScreenUtil().setHeight(60),
                    width: double.infinity,
                    child: RaisedButton(
                      color: primary,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () => _onLoginButtonPressed(),
                      child: Text("ĐĂNG NHẬP",
                          style: Theme
                              .of(context)
                              .primaryTextTheme
                              .button!
                              .copyWith(
                            fontSize: ScreenUtil().setSp(18),
                          )),
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}

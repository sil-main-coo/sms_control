import 'package:flutter/material.dart';
import 'package:sms_control/views/home/home_builder.dart';
import 'package:sms_control/views/widgets/dialogs/dialogs.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      final userName = _userCtrl.text.trim();
      final password = _passwordCtrl.text.trim();

      if (userName == 'admin' && password == '123456') {
        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeBuilder()),
          (_) => false,
        );
      } else {
        AppDialog.showNotifyDialog(
            context: context,
            mess: 'Sai tài khoản hoặc mật khẩu. Vui lòng thử lại!',
            textBtn: 'OK',
            function: () => Navigator.pop(context),
            color: Colors.blue);
      }
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _bodyLogin(),
    );
  }

  _bodyLogin() {
    final scSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "ĐĂNG NHẬP",
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          SizedBox(
            height: scSize.height / 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _userCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Trường bắt buộc';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Tài khoản"),
                        ),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Trường bắt buộc';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Mật khẩu",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: SizedBox(
                            height: scSize.height / 14,
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () => _login(),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "ĐĂNG NHẬP",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

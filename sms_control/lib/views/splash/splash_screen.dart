
import 'package:sms_control/views/login/login.dart';
import 'package:sms_control/views/widgets/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Login();
    // return AppLoadingWidget(mess: 'Kiểm tra đăng nhập...',);
  }
}

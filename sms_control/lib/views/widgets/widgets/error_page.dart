import 'dart:ui';

import 'package:sms_control/configs/values/colors.dart';
import 'package:sms_control/configs/values/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorPage extends StatelessWidget {
  final String mess;
  final IconData iconData;
  final Function function;

  const AppErrorPage({required this.mess, required this.iconData, required this.function});


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: primary,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Container(
              color: primary,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(iconData, color: secondary,),
                    SizedBox(height:  ScreenUtil().setHeight(10),),
                    Text(mess.toString(), style: Theme
                        .of(context)
                        .primaryTextTheme
                        .subtitle!
                        .copyWith(fontSize: ScreenUtil().setSp(fzSubTitle)),
                    ),
                    SizedBox(height:  ScreenUtil().setHeight(10),),
                    RaisedButton.icon(
                      onPressed: () => function(),
                      icon: Icon(Icons.refresh, color: colorIconWhite,),
                      color: secondary,
                      label: Text('Thử lại', style: Theme
                          .of(context)
                          .primaryTextTheme
                          .button!
                          .copyWith(fontSize: ScreenUtil().setSp(fzButton)),),
                    )
                  ],
                ),
              )
          ),
        )
    );
  }
}
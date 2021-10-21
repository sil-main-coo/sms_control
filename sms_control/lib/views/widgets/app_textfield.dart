
import 'package:sms_control/configs/values/validator.dart';
import 'package:sms_control/configs/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// input [TextEditingController] `ctrl` corresponding to text field you need
/// [FieldValid] is case valid in validatorR
/// [TextInputAction] is action of keyboard
/// `isNext` = true if you want to nextFocus, `isNext` = true if you want to unFocus

class AppTextField {
  static Widget tfOnBody(BuildContext context, TextEditingController ctrl,
      String label, TextInputAction action, bool isNext,
      {bool obscureText = false}) {
    return TextFormField(
        controller: ctrl,
        validator: (value) => AppValidator.checkValidator(value),
        onFieldSubmitted: (v){
          isNext ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus();
        },
        textInputAction: action,
        obscureText: obscureText,
        cursorColor: primary,
        style: Theme.of(context).primaryTextTheme.subtitle!.copyWith(
            fontSize: ScreenUtil().setSp(
              fzBody2,
            ),
            color: colorTextBlack),
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            labelText: label,
            labelStyle: Theme.of(context).primaryTextTheme.subtitle!.copyWith(
                fontSize: ScreenUtil().setSp(
                  fzBody2,
                ),
                color: Colors.grey),
            fillColor: colorIconBlack,
            errorStyle: Theme.of(context).primaryTextTheme.caption!.copyWith(
                fontSize: ScreenUtil().setSp(
                  fzCaption,
                ),
                color: Colors.red),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: borderBlack),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: secondary),
            )));
  }

}

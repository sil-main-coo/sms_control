import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:sms_control/configs/values/text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.color = Colors.blue})
      : super(key: key);

  final Function onPressed;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: RaisedButton(
        onPressed: () => onPressed(),
        color: color,
        child: Text(
          label.toUpperCase(),
          style: buttonWhite.copyWith(fontSize: 18.sp),
        ),
      ),
    );
  }
}

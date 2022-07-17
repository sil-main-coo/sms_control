import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_control/configs/values/text_styles.dart';
import 'package:sms_control/models/device.dart';
import 'package:sms_control/views/location/location_builder.dart';
import 'package:telephony/telephony.dart';

class ControlDeviceContainer extends StatelessWidget {
  ControlDeviceContainer({Key? key, required this.device}) : super(key: key);

  final Vehicle device;

  final telephony = Telephony.instance;

  Future<void> _sendSMS(String message) async {
    try {
      telephony.sendSms(
          to: device.sdt!, message: message, statusListener: onSendStatus);
    } catch (error) {
      print(error.toString());
    }
  }

  onSendStatus(SendStatus status) {
    // setState(() {
    // _message = status == SendStatus.SENT ? "sent" : "delivered";
    print(status);
    Fluttertoast.showToast(
        msg: 'Đã gửi tin nhắn',
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white);

    // });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _info(),
          SizedBox(
            height: 8.w,
          ),
          Divider(),
          SizedBox(
            height: 8.w,
          ),
          _control(context)
        ],
      ),
    );
  }

  Widget _info() {
    final titleStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22.sp, color: Colors.blue[600]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THÔNG TIN',
          style: titleStyle,
        ),
        SizedBox(
          height: 8.w,
        ),
        _labelValueText('Tên xe: ', device.ten?.toUpperCase()),
        _labelValueText('Biển số: ', device.bienSo),
        _labelValueText('Số điện thoại: ', device.sdt),
      ],
    );
  }

  Widget _control(BuildContext context) {
    final titleStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 22.sp, color: Colors.blue[600]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ĐIỀU KHIỂN',
          style: titleStyle,
        ),
        SizedBox(
          height: 32.w,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: () async {
                  await _sendSMS('lock1');
                },
                child: Text('KHÓA'),
              ),
              RaisedButton(
                onPressed: () async {
                  await _sendSMS('lock0');
                },
                child: Text('MỞ KHÓA'),
              ),
              RaisedButton(
                onPressed: () async {
                  await _sendSMS('coi1');
                },
                child: Text('BẬT CÒI'),
              ),
              RaisedButton(
                onPressed: () async {
                  await _sendSMS('coi0');
                },
                child: Text('TẮT CÒI'),
              ),
              RaisedButton(
                onPressed: () async {
                  await _sendSMS('gps');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LocationBuilder(
                                vehicle: device,
                              )));
                },
                child: Text('ĐỊNH VỊ'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _labelValueText(String? label, [String? value]) {
    final labelStyle = body.copyWith(fontSize: 18.sp);
    final valueStyle = labelStyle.copyWith(
        fontWeight: FontWeight.w600, color: Colors.blueAccent);

    return RichText(
        text: TextSpan(
            style: labelStyle,
            text: label,
            children: [TextSpan(style: valueStyle, text: value)]));
  }
}

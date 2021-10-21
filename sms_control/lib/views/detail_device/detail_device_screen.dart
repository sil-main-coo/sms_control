import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_control/configs/values/text_styles.dart';
import 'package:sms_control/models/device.dart';
import 'package:sms_control/provider/local/device_local_provider.dart';
import 'package:sms_control/provider/singletons/get_it.dart';
import 'package:sms_control/views/widgets/floating_button_widget.dart';
import 'package:telephony/telephony.dart';

class DetailDeviceScreen extends StatefulWidget {
  DetailDeviceScreen(
      {Key? key,
      required this.device,
      required this.devices,
      required this.removeDeviceCallback})
      : super(key: key);

  final Device device;
  final List<Device> devices;
  final Function(Device) removeDeviceCallback;

  @override
  _DetailDeviceScreenState createState() => _DetailDeviceScreenState();
}

class _DetailDeviceScreenState extends State<DetailDeviceScreen> {
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
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

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      print('missing permission');
    }

    if (!mounted) return;
  }

  Future<void> _sendSMS(String message) async {
    try {
      telephony.sendSms(
          to: widget.device.SDT!,
          message: message,
          statusListener: onSendStatus);
    } catch (error) {
      print(error.toString());
    }
  }

  Future _handlingRemoveReport(BuildContext context) async {
    widget.devices.remove(widget.device);
    await locator.get<DeviceLocalProvider>().saveDevicesToLocal(widget.devices);
    widget.removeDeviceCallback(widget.device);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _removeReportDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text('Đồng ý xóa thiết bị này?'),
              actions: [
                RaisedButton(
                  onPressed: () async => await _handlingRemoveReport(context),
                  child: Text(
                    'ĐỒNG Ý',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                ),
                RaisedButton(
                    onPressed: () => Navigator.pop(context), child: Text('HỦY'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin thiết bị',
          style: titleWhite.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
            _control()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingButtonWidget(
        onPressed: () => _removeReportDialog(context),
        label: 'Xóa thiết bị',
        color: Colors.redAccent,
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
        _labelValueText('Mã khách hàng: ', widget.device.idKH),
        _labelValueText(
            'Họ và tên khách hàng: ', widget.device.tenKH?.toUpperCase()),
        _labelValueText('Số điện thoại khách hàng: ', widget.device.SDT),
        _labelValueText('Địa chỉ: ', widget.device.diaChi)
      ],
    );
  }

  Widget _control() {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _cirleButton('BẬT', () async {
              await _sendSMS('bat');
            }, Colors.blue, Colors.white),
            _cirleButton('TẮT', () async {
              await _sendSMS('tat');
            }, Colors.red, Colors.white)
          ],
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

  Widget _cirleButton(
      String label, Function onPressed, Color primary, Color onPrimary) {
    final style = buttonWhite.copyWith(fontSize: 20.sp);
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(
        label,
        style: style,
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(30.w),
        primary: primary, // <-- Button color
        onPrimary: onPrimary, // <-- Splash color
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_control/configs/values/text_styles.dart';
import 'package:sms_control/models/device.dart';
import 'package:sms_control/provider/local/device_local_provider.dart';
import 'package:sms_control/provider/singletons/get_it.dart';
import 'package:sms_control/views/detail_device/control_device_container.dart';
import 'package:telephony/telephony.dart';

class DetailDeviceScreen extends StatefulWidget {
  DetailDeviceScreen(
      {Key? key,
      required this.device,
      required this.devices,
      required this.removeDeviceCallback})
      : super(key: key);

  final Vehicle device;
  final List<Vehicle> devices;
  final Function(Vehicle) removeDeviceCallback;

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

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      print('missing permission');
    }

    if (!mounted) return;
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
              content: Text('Đồng ý xóa xe này?'),
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
          'Thông tin xe',
          style: titleWhite.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _removeReportDialog(context),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: ControlDeviceContainer(
        device: widget.device,
      ),
    );
  }
}

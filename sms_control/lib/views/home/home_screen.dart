import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_control/configs/values/text_styles.dart';
import 'package:sms_control/models/device.dart';
import 'package:sms_control/views/create_device/create_device_screen.dart';
import 'package:sms_control/views/detail_device/detail_device_screen.dart';
import 'package:sms_control/views/widgets/layout_have_floating_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.devices = const []}) : super(key: key);

  final List<Device>? devices;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Device> devices;

  @override
  void initState() {
    super.initState();
    devices = widget.devices ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thiết bị',
          style: titleWhite.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: _bodyHome(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CreateDeviceScreen(
                      devices: devices,
                      saveCallback: (device) {
                        setState(() {});
                      },
                    ))),
      ),
    );
  }

  Widget _bodyHome() {
    if (devices.isEmpty)
      return Center(
        child: Text('Danh sách trống. Hãy tạo thiết bị mới'),
      );

    return LayoutHaveFloatingButton(
      child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) => _item(devices[index]),
          separatorBuilder: (_, __) => Divider(),
          itemCount: devices.length),
    );
  }

  Widget _item(Device data) {
    final titleStyle = TextStyle(
        fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black);
    final valueStyle = TextStyle(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black);

    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => DetailDeviceScreen(
                    device: data,
                    devices: devices,
                    removeDeviceCallback: (device) {
                      setState(() {});
                    },
                  ))),
      leading: Icon(Icons.perm_device_info),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  style: titleStyle,
                  text: 'Mã khách hàng: ',
                  children: [
                TextSpan(text: '${data.idKH.toString()}', style: valueStyle)
              ])),
          RichText(
              text: TextSpan(
                  style: titleStyle,
                  text: 'Tên khách hàng: ',
                  children: [
                TextSpan(
                    text: data.tenKH,
                    style: valueStyle.copyWith(color: Colors.blue))
              ])),
          RichText(
              text: TextSpan(
                  style: titleStyle,
                  text: 'Số điện thoại: ',
                  children: [
                TextSpan(
                    text: data.SDT,
                    style: valueStyle.copyWith(color: Colors.blue))
              ])),
          RichText(
              text: TextSpan(style: titleStyle, text: 'Địa chỉ: ', children: [
            TextSpan(text: '${data.diaChi.toString()}', style: valueStyle)
          ])),
        ],
      ),
    );
  }
}

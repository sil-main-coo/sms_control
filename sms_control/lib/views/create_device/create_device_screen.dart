import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_control/configs/values/text_styles.dart';
import 'package:sms_control/models/device.dart';
import 'package:sms_control/provider/local/device_local_provider.dart';
import 'package:sms_control/provider/singletons/get_it.dart';
import 'package:sms_control/views/widgets/app_field.dart';
import 'package:sms_control/views/widgets/floating_button_widget.dart';

class CreateDeviceScreen extends StatelessWidget {
  CreateDeviceScreen(
      {Key? key, required this.saveCallback, required this.devices})
      : super(key: key);

  final Function(Device) saveCallback;
  final List<Device> devices;

  final _customerCodeCtrl = TextEditingController();
  final _customerNameCtrl = TextEditingController();
  final _customerPhoneCtrl = TextEditingController();
  final _customerAddressCtrl = TextEditingController();

  final _customnerCodeNode = FocusNode();
  final _customnerNameNode = FocusNode();
  final _customerPhoneNode = FocusNode();
  final _customnerAddressNode = FocusNode();

  final _formKey = GlobalKey<FormState>(debugLabel: 'info');

  Future<void> saveDevice(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final device = Device(
        idKH: _customerCodeCtrl.text.trim(),
        tenKH: _customerNameCtrl.text.trim(),
        SDT: _customerPhoneCtrl.text.trim(),
        diaChi: _customerAddressCtrl.text.trim(),
      );

      devices.insert(0, device);
      await locator.get<DeviceLocalProvider>().saveDevicesToLocal(devices);

      saveCallback(device);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tạo mới thiết bị',
          style: titleWhite.copyWith(fontSize: 22.sp),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingButtonWidget(
        onPressed: () => saveDevice(context),
        label: 'Lưu lại',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppField(
                controller: _customerCodeCtrl,
                fcNode: _customnerCodeNode,
                nextFcNode: _customnerNameNode,
                autoFocus: true,
                textInputAction: TextInputAction.next,
                label: 'Mã khách hàng:',
                hintText: 'Nhập mã khách hàng',
              ),
              AppField(
                controller: _customerNameCtrl,
                label: 'Tên khách hàng:',
                isName: true,
                fcNode: _customnerNameNode,
                nextFcNode: _customerPhoneNode,
                textInputAction: TextInputAction.next,
                hintText: 'Nhập tên khách hàng',
              ),
              AppField(
                controller: _customerPhoneCtrl,
                label: 'Số điện thoại khách hàng:',
                isName: true,
                fcNode: _customerPhoneNode,
                nextFcNode: _customnerAddressNode,
                textInputAction: TextInputAction.next,
                hintText: 'Nhập SĐT khách hàng',
              ),
              AppField(
                controller: _customerAddressCtrl,
                textInputAction: TextInputAction.done,
                fcNode: _customnerAddressNode,
                isName: true,
                label: 'Địa chỉ khách hàng:',
                hintText: 'Nhập địa chỉ khách hàng',
              )
            ],
          ),
        ),
      ),
    );
  }
}

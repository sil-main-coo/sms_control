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
      {Key? key, required this.saveCallback, required this.vehicles})
      : super(key: key);

  final Function(Vehicle) saveCallback;
  final List<Vehicle> vehicles;

  final _customerCodeCtrl = TextEditingController();
  final _customerNameCtrl = TextEditingController();
  final _customerPhoneCtrl = TextEditingController();

  final _customnerCodeNode = FocusNode();
  final _customnerNameNode = FocusNode();
  final _customerPhoneNode = FocusNode();

  final _formKey = GlobalKey<FormState>(debugLabel: 'info');

  Future<void> saveDevice(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final device = Vehicle(
        bienSo: _customerCodeCtrl.text.trim(),
        ten: _customerNameCtrl.text.trim(),
        sdt: _customerPhoneCtrl.text.trim(),
      );

      vehicles.insert(0, device);
      await locator.get<DeviceLocalProvider>().saveDevicesToLocal(vehicles);

      saveCallback(device);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thêm mới xe',
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
                controller: _customerNameCtrl,
                label: 'Tên xe:',
                isName: true,
                fcNode: _customnerNameNode,
                nextFcNode: _customnerCodeNode,
                textInputAction: TextInputAction.next,
                hintText: 'Nhập tên xe',
              ),
              AppField(
                controller: _customerCodeCtrl,
                fcNode: _customnerCodeNode,
                nextFcNode: _customerPhoneNode,
                autoFocus: true,
                textInputAction: TextInputAction.next,
                label: 'Biển số:',
                hintText: 'Nhập biển số xe',
              ),
              AppField(
                controller: _customerPhoneCtrl,
                label: 'Số điện thoại:',
                isName: true,
                fcNode: _customerPhoneNode,
                textInputAction: TextInputAction.done,
                hintText: 'Nhập SĐT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

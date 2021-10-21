import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_control/configs/shared_preferences_keys.dart';
import 'package:sms_control/models/device.dart';

class DeviceLocalProvider {
  Future<List<Device>> getDevicesFromLocal() async {
    List<Device> devices = [];
    final sharedPrefs = await SharedPreferences.getInstance();
    final rawData = sharedPrefs.getString(SharedPrefsKeys.devices);
    if (rawData != null) {
      final json = jsonDecode(rawData);

      json.forEach((v) {
        devices.add(Device.fromJson(v));
      });
    }

    return devices;
  }

  Future<bool> saveDevicesToLocal(List<Device> devices) async {
    final devicesJson = devices.map((v) => v.toJson()).toList();

    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setString(
        SharedPrefsKeys.devices, jsonEncode(devicesJson));
  }

  Future<bool> removeDevicesFromLocal() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.remove(SharedPrefsKeys.devices);
  }
}

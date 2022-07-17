import 'package:flutter/material.dart';
import 'package:sms_control/models/device.dart';
import 'package:sms_control/provider/local/device_local_provider.dart';
import 'package:sms_control/provider/singletons/get_it.dart';

import 'home_screen.dart';

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: locator.get<DeviceLocalProvider>().getDevicesFromLocal(),
      builder: (BuildContext context, AsyncSnapshot<List<Vehicle>> snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(devices: snapshot.data);
        }

        return Scaffold(
          body: Center(
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

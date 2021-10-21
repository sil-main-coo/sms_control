import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'models/device.dart';
import 'provider/local/device_local_provider.dart';
import 'provider/singletons/get_it.dart';
import 'views/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(411.4, 843.4),
        builder: () => GestureDetector(
              onTap: () {
                FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: MaterialApp(
                title: 'Quản lý thiết bị',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: FutureBuilder<List<Device>>(
                  future:
                      locator.get<DeviceLocalProvider>().getDevicesFromLocal(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Device>> snapshot) {
                    if (snapshot.hasData) {
                      return HomeScreen(devices: snapshot.data);
                    }

                    return Scaffold(
                      body: Center(
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ));
  }
}

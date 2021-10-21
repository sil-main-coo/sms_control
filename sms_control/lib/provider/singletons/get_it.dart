
import 'package:get_it/get_it.dart';
import 'package:sms_control/app_bloc/bloc.dart';
import 'package:sms_control/provider/local/authen_local_provider.dart';
import 'package:sms_control/provider/local/device_local_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<AuthenLocalProvider>(() => AuthenLocalProvider());
  locator.registerFactory<DeviceLocalProvider>(() => DeviceLocalProvider());

  locator.registerLazySingleton<AppBloc>(() => AppBloc(locator()));
}

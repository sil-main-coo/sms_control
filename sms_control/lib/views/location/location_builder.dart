import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sms_control/main.dart';
import 'package:sms_control/models/device.dart';
import 'package:telephony/telephony.dart';

import 'location_device_screen.dart';

class LocationBuilder extends StatefulWidget {
  const LocationBuilder({Key? key, required this.vehicle}) : super(key: key);

  final Vehicle vehicle;

  @override
  _LocationBuilderState createState() => _LocationBuilderState();
}

class _LocationBuilderState extends State<LocationBuilder> {
  final telephony = Telephony.instance;
  LocationData? _currentLocation;

  _onNewMessage(SmsMessage message) {
    final body = message.body;
    if (body != null) {
      final arr = body.split(',');
      if (arr.length == 2) {
        setState(() {
          _currentLocation = LocationData.fromMap({
            'latitude': double.parse(arr[0]),
            'longitude': double.parse(arr[1])
          });
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    telephony.listenIncomingSms(
        onNewMessage: _onNewMessage,
        onBackgroundMessage: backgrounMessageHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Định vị: ${widget.vehicle.ten} (${widget.vehicle.bienSo})'),
      ),
      body: _renderBody(),
    );
  }

  Widget _renderBody() {
    if (_currentLocation == null) {
      return const Scaffold(
        body: Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return LocationDeviceScreen(
      location: _currentLocation!,
    );
  }
}

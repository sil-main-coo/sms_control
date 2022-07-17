import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sms_control/views/detail_device/map_bloc.dart';

class LocationDeviceScreen extends StatefulWidget {
  const LocationDeviceScreen({Key? key, required this.location})
      : super(key: key);

  final LocationData location;

  @override
  _LocationDeviceScreenState createState() => _LocationDeviceScreenState();
}

class _LocationDeviceScreenState extends State<LocationDeviceScreen> {
  Completer<GoogleMapController> _controller = Completer();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Marker> allMarker = [];
  late LocationData _currentLocation;

  void _initialData() async {
    _currentLocation = widget.location;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          _currentLocation.latitude!,
          _currentLocation.longitude!,
        ),
        zoom: 17)));
  }

  @override
  void initState() {
    super.initState();
    _initialData();
  }

  @override
  Widget build(BuildContext context) {
    final mapBloc = MapBloc();
    mapBloc.getBytesFromCanvas(50, 50);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            StreamBuilder<Uint8List>(
                stream: mapBloc.stIcon,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                      if (snapshot.data == null)
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      return _buildMap(snapshot.data!);
                    case ConnectionState.done:
                  }
                  return SizedBox(); // unreachable
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        child: Icon(Icons.my_location),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          _currentLocation.latitude!,
          _currentLocation.longitude!,
        ),
        zoom: 17)));
  }

  Widget _buildMap(Uint8List icon) {
    if (allMarker.isNotEmpty) {
      allMarker.clear();
    }
    allMarker.add(Marker(
        markerId: MarkerId('current'),
        draggable: false,
        position:
            LatLng(_currentLocation.latitude!, _currentLocation.longitude!),
        icon: BitmapDescriptor.fromBytes(icon),
        onTap: () {
          // _scaffoldKey.currentState.showBottomSheet(
          //       (context){
          //     return BottomSheetContainer();
          //   },
          // );
        }));
    return GoogleMap(
      markers: Set.from(allMarker),
      zoomGesturesEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      scrollGesturesEnabled: true,
      trafficEnabled: true,
      mapType: MapType.terrain,
      initialCameraPosition: CameraPosition(
        target: LatLng(_currentLocation.latitude!, _currentLocation.longitude!),
        zoom: 17,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}

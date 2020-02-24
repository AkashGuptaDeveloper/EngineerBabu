import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/GlobalComponent/ColorCode.dart';
import 'package:googlemap/NavigationDrawer/NavigationDrawer.dart';
import 'package:location/location.dart';
import 'package:googlemap/GlobalComponent/FlagString.dart';
//--------------------------------------------------------------------------------------------//
void main() {
  runApp(new MyApp());
}
//--------------------------------------------------------------------------------------------//
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}
//--------------------------------------------------------------------------------------------//
class _MyAppState extends State<MyApp> {
  LocationData _startLocation;
  LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;
  Location _locationService = new Location();
  bool _permission = false;
  String error;
  bool currentWidget = true;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCamera = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );
  CameraPosition _currentCameraPosition;
  GoogleMap googleMap;
  var cityText;
  var State;
  var subLocality;
  var subAdminArea;
  var addressLine;
  var featureName;
  var CurrentL;
  var featurelatitude;
  var featurelongitude;

//--------------------------------------------------------------------------------------------//
  @override
  void initState() {
    super.initState();
    this.initPlatformState();
  }

//--------------------------------------------------------------------------------------------//
  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.HIGH,
    );
    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      //print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        //print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));
            final coordinates =
            new Coordinates(result.latitude, result.longitude);
            var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
            var first = addresses.first;
            if (mounted) {
              setState(() {
                featurelatitude = result.latitude;
                featurelongitude = result.longitude;
                _currentLocation = result;
                cityText = first.locality;
                State = first.adminArea;
                State = first.adminArea;
                State = first.subLocality;
                subAdminArea = first.subAdminArea;
                addressLine = first.addressLine;
                featureName = first.featureName;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }
    setState(() {
      _startLocation = location;
      cityText.toString();
      State.toString();
      State.toString();
      State.toString();
      subAdminArea.toString();
      addressLine.toString();
      featureName.toString();
    });
  }
//----------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;
//----------------------------------------------------------------------------//
    googleMap = GoogleMap(
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: _initialCamera,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
//----------------------------------------------------------------------------//
    widgets = [
      Center(
        child: SizedBox(height: 400.0, child: googleMap),
      ),
    ];
//----------------------------------------------------------------------------//
    widgets.add(new Center(
        child: new Text(
            _currentLocation != null
                ? 'Continuous location: \nlat: ${_currentLocation.latitude} & long: ${_currentLocation.longitude} \nalt: ${_currentLocation.altitude}m\n'
                : 'Error: $error\n',
            textAlign: TextAlign.center)));
//--------------------------------------------------------------------------------------------//
    widgets.add(Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(GlobalFlagString.UserCurrentAddress.toString()+"   "+ addressLine.toString(),style: TextStyle(fontSize: 15.0,color:ColorCode.AppColorCode,fontWeight: FontWeight.w300),),
      ],
    ));
//--------------------------------------------------------------------------------------------//
    return new Scaffold(
          drawer: _drawer(),
          appBar: new AppBar(
            title: new Text(GlobalFlagString.UserLocation.toString()),
            backgroundColor: ColorCode.AppColorCode,
            centerTitle: true,
          ),
          body: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        );
  }
//----------------------------Widget _drawer----------------------------------//
  Widget _drawer() {
    return new Drawer(
      elevation: 20.0,
      child: NavigationDrawer(),
    );
  }
}
//-----------------------------------------------------------------------------//
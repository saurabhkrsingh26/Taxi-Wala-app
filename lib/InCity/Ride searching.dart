import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/model/carLiveModel.dart';
import 'package:taxiwala/res/provider/car_live_provider.dart';

class RideSearching extends StatefulWidget {
  const RideSearching({super.key});

  @override
  State<RideSearching> createState() => _RideSearchingState();
}

class _RideSearchingState extends State<RideSearching> {
  List<LatLng> coordinateList = [];
  Completer<GoogleMapController> googleMapController = Completer();

  CameraPosition cameraPosition =
  const CameraPosition(target: LatLng(20.5937, 78.9629));

  Uint8List? marketimages;
  List<Marker> markers = [];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Widget _getMap() {
    return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(markers),
        initialCameraPosition: cameraPosition,
        mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
          if (!googleMapController.isCompleted) {
            googleMapController.complete(controller);
          }
        });
  }

  void _addMarkers() async {
    final Uint8List locationIcon = await getImages(Images.cab, 70);
    for (int i = 0; i < coordinateList.length; i++) {
      var markerId = MarkerId(i.toString());
      markers.add(Marker(
        markerId: markerId,
        icon: BitmapDescriptor.fromBytes(locationIcon),
        position: coordinateList[i],
        infoWindow: InfoWindow(
          title: "Marker $i",
        ),
      ));
    }
    setState(() {});
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
    await myCarData(currentPosition.latitude.toString(),
        currentPosition.longitude.toString());
    _addMarkers();
  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 13.5)));
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      if (kDebugMode) {
        print("user don't enable location permission");
      }
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        if (kDebugMode) {
          print("user denied location permission");
        }
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print("user denied permission forever");
      }
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Widget _getLoctionButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap: () {
          _gotoUserCurrentPosition();
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
            ],
          ),
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Widget drawerWidget() {
    return Positioned(
      top: 50,
      left: 20,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.Menu);
        },
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 8,
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                color: ColorConstant.SEARCH_BG, shape: BoxShape.circle),
            child: const Icon(Icons.menu, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      drawerWidget(),
      _getLoctionButton(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _gotoUserCurrentPosition();
  }

  CarLiveProvider carTypeProvider = CarLiveProvider();

  Future<void> myCarData(
      String lat,
      String lng,
      ) async {
    try {
      List<CarLiveModel> carList = await carTypeProvider.carLiveType(
        lat,
        lng,
      );
      if (carList.isNotEmpty) {
        setState(() {
          for (int i = 0; i < carList.length; i++) {
            var data = carList[i];
            coordinateList.add(LatLng(double.parse(data.latitude.toString()),
                double.parse(data.longitude.toString())));
            if (kDebugMode) {
              print("coordinateList:$coordinateList");
            }
          }
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching reviews data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildBody(),
            DraggableScrollableSheet(
              initialChildSize: 0.5, // Initial percentage of screen occupied by the bottom sheet
              minChildSize: 0.5, // Minimum percentage of screen occupied by the bottom sheet
              maxChildSize: 0.5, // Maximum percentage of screen occupied by the bottom sheet
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Column(
                        children: [
                          Container(
                            height:height*0.005,
                            width:width*0.55,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey[200]
                            ),
                          ),
                          SizedBox(height:height*0.04),
                          SizedBox(
                            height:height*0.05,
                            child: Text('Searching for your ride',style: robotoBlackProfile,),
                          ),
                          Container(
                            height:height*0.28,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Images.summary),
                                )
                            ),
                          ),
                          SizedBox(height:height*0.02),
                          ColorButton(onTap: () {
                            Navigator.pushNamed(context, RoutesName.RideConfirmation);
                          }, text: 'Cancel', btnColor:Colors.grey, textColor: ColorConstant.Black_COLOR,),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
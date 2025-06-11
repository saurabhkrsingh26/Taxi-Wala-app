// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RideConfirmation extends StatefulWidget {
  const RideConfirmation({super.key});

  @override
  State<RideConfirmation> createState() => _RideConfirmationState();
}

class _RideConfirmationState extends State<RideConfirmation> {
  List<LatLng> routeCoordinates = [];
  Set<Polyline> polyLines = {};
  bool isPolylineCreated = false;
  List<LatLng> coordinateList = [];
  final double lat =26.8542;
  final double lng = 80.9448;
  Future<void> _fetchRouteCoordinates() async {
    try {
      Position currentPosition = await _determineUserCurrentPosition();
      setState(() {
        routeCoordinates = [
          LatLng(lat, lng),
          LatLng(currentPosition.latitude, currentPosition.longitude),
        ];
      });
      await fetchAndDrawPolyline();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching route coordinates: $error');
      }
    }
  }
  Future<void> fetchAndDrawPolyline() async {
    try {
      polyLines.clear();
      List<LatLng> polylineCoordinates = [];
      for (int i = 0; i < routeCoordinates.length - 1; i++) {
        final start = routeCoordinates[i];
        final end = routeCoordinates[i + 1];
        final response = await http.get(Uri.parse(
            'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=driving&key=AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'));
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          final List<dynamic> routes = data['routes'];
          if (routes.isNotEmpty) {
            final List<dynamic> legs = routes[0]['legs'];
            if (legs.isNotEmpty) {
              final List<dynamic> steps = legs[0]['steps'];
              if (steps.isNotEmpty) {
                for (int j = 0; j < steps.length; j++) {
                  final List<dynamic> points =
                  decodePolyline(steps[j]['polyline']['points']);
                  if (points.isNotEmpty) {
                    setState(() {
                      polylineCoordinates.addAll(points as Iterable<LatLng>);
                    });
                  }
                }
              }
            }
          }
        }
      }
      polyLines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.black,
          points: polylineCoordinates,
          width: 6,
        ),
      );
      isPolylineCreated = true;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching and drawing polyline: $error');
      }
    }
  }

  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    double lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }
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
        polylines: polyLines,
        initialCameraPosition: cameraPosition,
        mapType: MapType.terrain,
        onMapCreated: (GoogleMapController controller) {
          if (!googleMapController.isCompleted) {
            googleMapController.complete(controller);
          }
        });
  }

  void _addMarkers() async {
    final Uint8List locationIcon = await getImages(Images.girl, 70);
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
    if (routeCoordinates.isNotEmpty) {
      final Uint8List startMarkerIcon = await getImages(Images.cab, 70);
      final Uint8List endMarkerIcon = await getImages(Images.locationPin, 70);
      markers.add(Marker(
        markerId: const MarkerId("start"),
        icon: BitmapDescriptor.fromBytes(startMarkerIcon),
        position: routeCoordinates.first,
        infoWindow: const InfoWindow(
          title: "Start Point",
        ),
      ));
      markers.add(Marker(
        markerId: const MarkerId("end"),
        icon: BitmapDescriptor.fromBytes(endMarkerIcon),
        position: routeCoordinates.last,
        infoWindow: const InfoWindow(
          title: "End Point",
        ),
      ));
    }
    setState(() {
      Set<Marker> markers = {};
      markers = markers.toSet();
    });
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
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
  // Widget mapWidget() {
  //   return Positioned(
  //     top: 300,
  //     right: 20,
  //     child: Container(
  //       width: 50,
  //       height: 50,
  //       decoration: const BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: Colors.green),
  //       child: Center(
  //         child: IconButton(
  //           icon: const Icon(
  //             Icons.navigation_outlined,
  //             color: Colors.white,
  //           ),
  //           onPressed: () async {
  //             await launchUrl(Uri.parse(
  //                 'google.navigation:q=$lat, $lng&key=AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'));
  //           },
  //         ),
  //       ),
  //     )
  //   );
  // }
  Widget OTPWidget() {
    return Positioned(
      top: 60,
      left: 250,
      child:Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: ColorConstant.Black_COLOR,
          border: Border.all(width: 0.5,color: ColorConstant.WHITE_COL0R),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Column(
          children: [
            SizedBox(height:5,),
            Text("OTP",style: robotoMediumWhite,),
            Text("1234",style: robotoMediumExtraWhite,)
          ],
        ),
      ),
    );
  }
  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      OTPWidget(),
      drawerWidget(),
      // mapWidget(),
      _getLoctionButton(),
    ]);
  }

  @override
  void initState() {
    super.initState();
    _gotoUserCurrentPosition();
    _fetchRouteCoordinates();
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
              initialChildSize: 0.4,
              // Initial percentage of screen occupied by the bottom sheet
              minChildSize: 0.4,
              // Minimum percentage of screen occupied by the bottom sheet
              maxChildSize: 0.75,
              // Maximum percentage of screen occupied by the bottom sheet
              builder: (BuildContext context,
                  ScrollController scrollController) {
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
                      SizedBox(
                        height:height*0.8,
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                height:height*0.005,
                                width:width*0.65,
                                decoration: const BoxDecoration(
                                  color: ColorConstant.WHITE_BACKGROUND,
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                ),
                              ),
                            ),
                            SizedBox(height:height*0.02),
                            SizedBox(
                              height:height*0.035,
                              child: Center(child: Text('Your ride is confirmed',style: robotoBlackProfile,)),
                            ),
                            SizedBox(height:height*0.01),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:height*0.13,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width:width*0.4,
                                              child: Column(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 30),
                                                    child: Text('TN78CA9571',
                                                      style: robotoMediumBlack,),
                                                  ),
                                                  SizedBox(height:height*0.005),
                                                  const Padding(
                                                    padding: EdgeInsets.only(right: 50),
                                                    child: Text('Red Swift Taxi',
                                                      style: robotoSmallGrey,),
                                                  ),
                                                  SizedBox(height:height*0.005),
                                                  const Padding(
                                                      padding: EdgeInsets.only(right: 10),
                                                      child:Row(
                                                        children: [
                                                          SizedBox(
                                                            child: Text("Driver",style: robotoBlack,),
                                                          ),
                                                          SizedBox(
                                                            child: Icon(Icons.star,color: Colors.amberAccent,),
                                                          ),
                                                          SizedBox(
                                                            child: Text("4.3",style: robotoBlack,),
                                                          ),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width:width*0.009),
                                            SizedBox(
                                              width:width*0.4,
                                              child: const Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 60),
                                                    child: CircleAvatar(
                                                      radius: 35,
                                                      backgroundImage: AssetImage(Images.cab),
                                                      backgroundColor: ColorConstant
                                                          .WHITE_BACKGROUND,
                                                    ),
                                                  ),
                                                  Positioned(
                                                      left: 0,
                                                      child: CircleAvatar(
                                                          radius: 35,
                                                          backgroundImage: AssetImage(Images.girl)
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:height*0.07,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                Uri phoneno = Uri.parse('tel:+9177398877023');
                                                if (await launchUrl(phoneno)) {
                                                //dialer opened
                                                }else{
                                                //dailer is not opened
                                                }
                                              },
                                              child: Container(
                                                height: height*0.06,
                                                width:width*0.12,
                                                decoration: const BoxDecoration(
                                                    color: ColorConstant.Black_COLOR,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(13))
                                                ),
                                                child: const Icon(Icons.call,
                                                  color: ColorConstant
                                                      .WHITE_BACKGROUND,),
                                              ),
                                            ),
                                            SizedBox(width:width*0.04),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Constant_text_field(
                                                controller: null,
                                                keyboardType: TextInputType.name,
                                                hintText: 'Message...',
                                                filled: true,
                                                // validator: Validate_Name,
                                                height: height*0.06,
                                                width: width*0.67,
                                                fillColor: Colors.grey[300],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height:height*0.01),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height:height*0.1,
                                          width:width*0.12,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(Images.tofrom),
                                              )
                                          ),
                                        ),
                                        SizedBox(
                                          height:height*0.15,
                                          width:width*0.7,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(height:height*0.006),
                                              Constant_text_field(
                                                controller: null,
                                                enabled: false,
                                                keyboardType: TextInputType.name,
                                                hintText: 'Railway Satation',
                                                filled: true,
                                                height:height*0.065,
                                                width: width*0.7,
                                                fillColor: Colors.grey[300],
                                              ),
                                              Constant_text_field(
                                                controller: null,
                                                enabled: false,
                                                keyboardType: TextInputType.name,
                                                hintText: '2/07,Street name,Area,Code',
                                                filled: true,
                                                height:height*0.065,
                                                width: width*0.7,
                                                fillColor: Colors.grey[300],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.07,
                                      child: Row(
                                        children: [
                                          SizedBox(width:width*0.05),
                                          InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.Cancellation);
                                            },
                                            child: Container(
                                                height:height*0.055,
                                                width:width*0.23,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  color: ColorConstant.Black_COLOR,
                                                ),
                                                child: const Center(child: Text('Cancel',style: robotoMediumExtraWhite,))
                                            ),
                                          ),
                                          SizedBox(width:width*0.05),
                                          InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.SupportIncity);
                                            },
                                            child: Container(
                                                height:height*0.055,
                                                width:width*0.23,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  color: ColorConstant.Black_COLOR,
                                                ),
                                                child: const Center(child: Text('Support',style: robotoMediumExtraWhite,))
                                            ),
                                          ),
                                          SizedBox(width:width*0.05),
                                          Container(
                                              height:height*0.055,
                                              width:width*0.23,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: ColorConstant.Black_COLOR,
                                              ),
                                              child: const Center(child: Text('Share',style: robotoMediumExtraWhite,))
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: height*0.044,
                                          child: Text('  Total fare:',style: robotoRegularBlack,),
                                        ),
                                        SizedBox(
                                          height: height*0.044,
                                          child: const Center(child: Text('      ₹ 160',style: robotoMediumBlack,)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width:width*0.017),
                                        Container(
                                          height: height*0.045,
                                          width:width*0.09,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(Images.cash)
                                              )
                                          ),
                                        ),
                                        SizedBox(
                                          height: height*0.045,
                                          width:width*0.16,
                                          child: const Center(child: Text('Cash',style: robotoMediumBlack,)),
                                        ),
                                        const SizedBox(width: 130,),
                                        Container(
                                          height: height*0.04,
                                          width:width*0.23,
                                          decoration: const BoxDecoration(
                                            color: ColorConstant.Black_COLOR,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          child: const Center(child: Text('Change',style: robotoMediumExtraWhite,)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
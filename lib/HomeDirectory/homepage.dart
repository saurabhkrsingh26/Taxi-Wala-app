// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/SelfDriving/Rentals.dart';
import 'package:taxiwala/model/carLiveModel.dart';
import 'package:taxiwala/res/provider/car_live_provider.dart';
import 'package:http/http.dart' as http;
import '../Constant/Constant_textfield/CustomTextField.dart';
import '../Constant/CustomButton/smallButton.dart';
import '../model/carTypeModel.dart';
import '../res/provider/carBookingProvider.dart';
import '../res/provider/carTypeProvider.dart';

List<LatLng> routeCoordinates = [];
Set<Polyline> polyLines = {};
bool isPolylineCreated = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<LatLng> coordinateList = [];
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
    if (routeCoordinates.isNotEmpty) {
      final Uint8List startMarkerIcon = await getImages(Images.locationPin, 70);
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
  Future<void> _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
    await myCarData(currentPosition.latitude.toString(),
        currentPosition.longitude.toString());
    _addMarkers();
    await fetchAndDrawPolyline();
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
    myReviewData();
    Future.delayed(Duration.zero, () {
      Map<String, dynamic>? args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('LocationData')) {
        String locationName = args['LocationData']['locationName'];
        String conlat = args['LocationData']['Latitude'];
        String conlong = args['LocationData']['longitude'];
        from.text = locationName;
        fromlat = double.parse(conlat);
        fromlong = double.parse(conlong);
        if (routeCoordinates.length >= 2) {
          routeCoordinates.removeAt(0);
        }
        routeCoordinates.add(LatLng(fromlat, fromlong));
      }
    });
  }

  List<CarTypeModel> data = [];
  CarTypeProvider carTypeProvider = CarTypeProvider();
  Future<void> myReviewData() async {
    // cartItems.clear();
    try {
      List<CarTypeModel> carList = await carTypeProvider.carType();
      setState(() {
        data = carList;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching reviews data: $e');
      }
    }
  }

  CarLiveProvider carType = CarLiveProvider();
  Future<void> myCarData(
    String lat,
    String lng,
  ) async {
    try {
      List<CarLiveModel> carList = await carType.carLiveType(
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

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Exit App',
                style: robotoMediumBlack,
              ),
              content: const Text(
                'Do you want to exit an App?',
                style: robotoBold,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text(
                        'No',
                        style: robotoBlack,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      //return true when click on "Yes"
                      child: const Text(
                        'Yes',
                        style: robotoBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildBody(),
            DraggableScrollableSheet(
              initialChildSize:
                  0.5, // Initial percentage of screen occupied by the bottom sheet
              minChildSize:
                  0.5, // Minimum percentage of screen occupied by the bottom sheet
              maxChildSize:
                  0.6, // Maximum percentage of screen occupied by the bottom sheet
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Container(
                        width: width * 0.5,
                        decoration: const BoxDecoration(
                          color: ColorConstant.WHITE_BACKGROUND,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 1.43,
                      color: ColorConstant.WHITE_COL0R,
                      child: DefaultTabController(
                          length: 2, // Number of tabs
                          child: Column(children: [
                            Container(
                              constraints: const BoxConstraints.expand(
                                  height: 50), // Adjust the height as needed
                              child: TabBar(
                                indicatorColor: ColorConstant.Black_COLOR,
                                dividerColor: ColorConstant.BORDER_COLOR,
                                tabs: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Images.yellow),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Images.Red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: height * 0.5,
                                child: TabBarView(children: [
                                  ListView(
                                    // shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    children: [
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: height * 0.13,
                                            width: width * 0.13,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Images.tofrom))),
                                          ),
                                          SizedBox(
                                            width: width * 0.85,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _selectLocation("from");
                                                      },
                                                      child:
                                                          Constant_text_field(
                                                        enabled: false,
                                                        controller: from,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        hintText:
                                                            '2/07,Street name,Area,Code',
                                                        filled: true,
                                                        height: height * 0.065,
                                                        width: width * 0.7,
                                                        fillColor:
                                                            Colors.grey[300],
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _selectLocation("to");
                                                      },
                                                      child:
                                                          Constant_text_field(
                                                        enabled: false,
                                                        controller: to,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        hintText:
                                                            'Set destination',
                                                        filled: true,
                                                        height: height * 0.065,
                                                        width: width * 0.7,
                                                        fillColor:
                                                            Colors.grey[300],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: height * 0.008,
                                                  left: width * 0.65,
                                                  child: Container(
                                                    height: height * 0.09,
                                                    width: width * 0.13,
                                                    decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .WHITE_COL0R,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                      border: Border.all(
                                                          color: ColorConstant
                                                              .WHITE_BACKGROUND,
                                                          width: 0.5),
                                                    ),
                                                    child: const Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .watch_later_outlined,
                                                          color: ColorConstant
                                                              .Black_COLOR,
                                                          size: 30,
                                                        ),
                                                        Text(
                                                          'Now',
                                                          style: robotoBlack,
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
                                      from.text.isNotEmpty && to.text.isNotEmpty
                                          ? bookCar()
                                          : usedtofrom(),
                                    ],
                                  ),
                                  const Rentals(),
                                ]))
                          ])),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  var fromlat, fromlong, tolat, tolong;
  void _selectLocation(String locationType) async {
    final selectedLocation = await Navigator.pushNamed(
        context, RoutesName.PickupLocation,
        arguments: locationType);
    if (selectedLocation != null && selectedLocation is Map<String, dynamic>) {
      if (locationType == 'from') {
        setState(() {
          from.text = selectedLocation['locationName'];
          fromlat = selectedLocation['latitude'];
          fromlong = selectedLocation['longitude'];
          if (routeCoordinates.length >= 2) {
            routeCoordinates.removeAt(0);
          }
          routeCoordinates.add(LatLng(fromlat, fromlong));
        });
      } else if (locationType == 'to') {
        setState(() {
          to.text = selectedLocation['locationName'];
          tolat = selectedLocation['latitude'];
          tolong = selectedLocation['longitude'];
          if (routeCoordinates.length >= 2) {
            routeCoordinates.removeAt(1);
          }
          routeCoordinates.add(LatLng(tolat, tolong));
        });
      }
      if (from.text.isNotEmpty || to.text.isNotEmpty) {
        calculateDistance(fromlat, fromlong, tolat, tolong);
        if (routeCoordinates.length >= 2) {
          await fetchAndDrawPolyline();
        }
      }
    }
  }

  var calculatedDistance;
  Future<void> calculateDistance(
      double fromlat, double fromlong, double tolat, double tolong) async {
    const String apiKey =
        "AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM"; // Replace with your Google Maps API key
    final String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$fromlat,$fromlong&destinations=$tolat,$tolong&key=$apiKey&mode=car";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        double distance =
            (jsonData['rows'][0]['elements'][0]['distance']['value'] as int) *
                0.001;
        setState(() {
          calculatedDistance = distance;
        });
      } else {
        if (kDebugMode) {
          print("API Request Failed with status code: ${response.statusCode}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
    }
  }

  final TextEditingController from = TextEditingController();
  final TextEditingController to = TextEditingController();
  Widget bookCar() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int changecolor = 0;
    final carBokkingProvider = Provider.of<CarBookingProvider>(context);
    return Column(
      children: [
        const Divider(
          color: Colors.transparent,
        ),
        Container(
          width: width * 0.45,
          decoration: const BoxDecoration(
            color: ColorConstant.Black_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(width: width * 0.05),
              const Icon(
                Icons.add_to_drive_rounded,
                color: ColorConstant.WHITE_COL0R,
                size: 20,
              ),
              SizedBox(width: width * 0.02),
              const Text(
                'Add Coupon',
                style: robotoMediumExtraWhite,
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.transparent,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              final calculatedPrice = calculatedDistance != null
                  ? int.parse(data[index].price_km.toString()) *
                      calculatedDistance
                  : null;
              return InkWell(
                onTap: () {
                  setState(() {
                    changecolor = 1;
                  });
                },
                child: Card(
                  color: changecolor == 1 ? Colors.green[200] : Colors.white,
                  child: ExpansionTile(
                    title: SizedBox(
                      width: width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.09,
                                  child: Image.network(
                                    data[index].image.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  child: Center(
                                      child: Text('2 min',
                                          style: robotoSmallGrey)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.34,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].car_type.toString(),
                                  style: robotoRegularBlack,
                                ),
                                const Text(
                                  "At Your doorstep",
                                  style: robotoBlack,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  calculatedPrice == null
                                      ? "0"
                                      : "₹${calculatedPrice.toStringAsFixed(0)}",
                                  style:
                                      robotoRegularBlack.copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      ListTile(
                          title: ColorButton(

                        onTap: () {
                          carBokkingProvider.carBooking(
                              context,
                              fromlat.toString(),
                              fromlong.toString(),
                              tolat.toString(),
                              tolong.toString(),
                              data[index].id.toString(),
                              calculatedPrice!.toStringAsFixed(1),
                              calculatedDistance.toString());
                        },
                        text: 'Book',
                        btnColor: ColorConstant.Green_BACKGROUND,
                        textColor: ColorConstant.WHITE_COL0R,
                      )),
                    ],
                  ),
                ),
              );
            }),
        SizedBox(
          height: height * 0.1,
        )
      ],
    );
  }

  Widget usedtofrom() {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Divider(color: Colors.transparent,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.home_outlined,
              size: 30,
            ),
            const Text(
              '   Home',
              style: robotoBlack,
            ),
            SizedBox(
              width: width * 0.02,
            ),
            const Icon(
              Icons.card_travel,
              size: 30,
            ),
            const Text(
              '   Work',
              style: robotoBlack,
            ),
            SizedBox(
              width: width * 0.02,
            ),
            const Icon(
              Icons.star_border,
              size: 30,
            ),
            const Text(
              '   Favourites',
              style: robotoBlack,
            ),
          ],
        ),
        const Divider(color: Colors.transparent,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width * 0.15,
              child: const Column(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.76,
              child: const Column(
                children: [
                  Text(
                    'Seetharampuram,vijayawada,Andhra\nPradesh',
                    style: robotoSmallGrey,
                  ),
                  Divider(),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Text(
                    'Seetharampuram,vijayawada,Andhra\nPradesh',
                    style: robotoSmallGrey,
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

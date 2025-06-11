// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/Constant/Constant_textfield/ApiConstant.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class Cancellation extends StatefulWidget {
  const Cancellation({super.key});

  @override
  State<Cancellation> createState() => _CancellationState();
}

class _CancellationState extends State<Cancellation> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  _init() {
    _defaultLatLng = const LatLng(20.5937, 78.9629);
    _cameraPosition = CameraPosition(target: _defaultLatLng, zoom: 10.5);
    _gotoUserCurrentPosition();
  }

  Widget _getMap() {
    return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: _cameraPosition!,
        mapType: MapType.terrain,
        onCameraIdle: () {},
        onCameraMove: (cameraPosition) {},
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        });
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
    setState(() async {});
  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 13.5)));
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {}
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {}
    }

    if (locationPermission == LocationPermission.deniedForever) {}
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  final List<dynamic> _suggestions = [];

  Future<Map<String, double>> getLatLngFromPlaceId(
      String placeId, String address) async {
    const apiKey = Apiconst.mapkey;
    final response = await http
        .get(Uri.parse('${Apiconst.map_get_lat_long}$placeId&key=$apiKey'));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      if (decodedResponse['status'] == 'OK') {
        final location = decodedResponse['result']['geometry']['location'];
        searchedLocationLatitude = location['lat'];
        searchedLocationLongitude = location['lng'];
        if (searchedLocationLongitude != null &&
            searchedLocationLatitude != null) {
          _suggestions.clear();
          final searchlatlan =
              LatLng(searchedLocationLatitude, searchedLocationLongitude);
          _gotoSpecificPosition(searchlatlan);
        }

        return {
          'latitude': searchedLocationLatitude,
          'longitude': searchedLocationLongitude
        };
      } else {
        throw Exception(
            'Failed to fetch location details: ${decodedResponse['error_message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch location details: ${response.statusCode}');
    }
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
            // border: Border.all(
            //   width: 1.2, color: Colors.black
            // ),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
            ],
          ),
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Widget drawer() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
            height: height * 0.06,
            width: width * 0.12,
            decoration: const BoxDecoration(
                color: ColorConstant.SEARCH_BG, shape: BoxShape.circle),
            child: const Icon(Icons.menu, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    var height = MediaQuery.of(context).size.height;
    return Stack(children: [
      _getMap(),
      drawer(),
      _getLoctionButton(),
      _suggestions.isNotEmpty
          ? Container(
              color: Colors.white,
              height: height / 3,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  location = _suggestions[index]['description'];
                  final placeId = _suggestions[index]['place_id'];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(
                      location.toString(),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      getLatLngFromPlaceId(placeId, location.toString());
                    },
                  );
                },
              ),
            )
          : const SizedBox(),
    ]);
  }

  String SearchAddress = "";

  String? location;
  var liveLocation;
  var searchedLocationLatitude;
  var searchedLocationLongitude;
  int changecolor = 0;
  final TextEditingController _onTapController =TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
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
              initialChildSize: 0.52,
              minChildSize: 0.52,
              maxChildSize: 0.54,
              builder:
                  (BuildContext context, ScrollController scrollController) {
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
                            height: height * 0.005,
                            width: width * 0.56,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey[350],
                            ),
                          ),
                          SizedBox(height: height * 0.020),
                          SizedBox(
                            height: height * 0.045,
                            child: Text(
                              'Driver is 5 min away...',
                              style: robotoBlackProfile,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.045,
                            child: const Text(
                              'Still want to cancel? Tell us why',
                              style: robotoBlack,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      changecolor = 1;
                                    });
                                    const newText = 'Driver denied drop location ';
                                    final updatedText = _onTapController.text + newText;
                                    _onTapController.value = _onTapController.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(offset: updatedText.length)
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      color: changecolor == 1
                                          ?  red
                                          : Colors.grey[200],
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Driver denied drop\nlocation',
                                        style: robotoBlack,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      changecolor = 2;
                                    });
                                    const newText = 'Didn\'t like car ';
                                    final updatedText = _onTapController.text + newText;
                                    _onTapController.value = _onTapController.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(offset: updatedText.length)
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      color: changecolor == 2
                                          ?  red
                                          : Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Didn\'t like car',
                                      style: robotoBlack,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      changecolor = 3;
                                    });
                                    const newText = 'Driver unreponsive on chat ';
                                    final updatedText = _onTapController.text + newText;
                                    _onTapController.value = _onTapController.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(offset: updatedText.length)
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      color: changecolor == 3
                                          ?  red
                                          : Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Driver unreponsive\non chat',
                                      style: robotoBlack,
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      changecolor = 4;
                                    });
                                    const newText = 'Driver demanded extra cash ';
                                    final updatedText = _onTapController.text + newText;
                                    _onTapController.value = _onTapController.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(offset: updatedText.length)
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      color: changecolor == 4
                                          ?  red
                                          : Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Driver demanded\nextra cash',
                                      style: robotoBlack,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      changecolor = 5;
                                    });
                                    const newText = 'Expected a shorter wait time ';
                                    final updatedText = _onTapController.text + newText;
                                    _onTapController.value = _onTapController.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(offset: updatedText.length)
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      color: changecolor == 5
                                          ?  red
                                          : Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Expected a shorter\nwait time',
                                      style: robotoBlack,
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      changecolor = 6;
                                    });
                                    const newText = 'My reason not listed ';
                                    final updatedText = _onTapController.text + newText;
                                    _onTapController.value = _onTapController.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(offset: updatedText.length)
                                    );
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      color: changecolor == 6
                                          ?  red
                                          : Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'My reason not listed',
                                      style: robotoBlack,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: height * 0.075,
                                  width: width * 0.43,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: const Center(
                                      child: Text('Cancel Ride',
                                    style: robotoMediumBlack,)),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, RoutesName.RideConfirmation);
                                  },
                                  child: Container(
                                    height: height * 0.075,
                                    width: width * 0.43,
                                    decoration: const BoxDecoration(
                                      color: ColorConstant.Black_COLOR,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Center(
                                        child: Text('Dont\'t cancel',
                                      style: robotoMediumExtraWhite,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

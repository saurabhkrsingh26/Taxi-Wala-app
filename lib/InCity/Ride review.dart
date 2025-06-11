// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'dart:convert';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/Constant/Constant_textfield/ApiConstant.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class Ridereview extends StatefulWidget {
  const Ridereview({super.key});

  @override
  State<Ridereview> createState() => _RidereviewState();
}

class _RidereviewState extends State<Ridereview> {
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
    return Positioned(
      top: 50,
      left: 20,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RoutesName.SupportIncity);
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
            child: const Icon(Icons.arrow_back_outlined, size: 40),
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
  final TextEditingController _onTapController = TextEditingController();
  final TextEditingController testing = TextEditingController();
  @override
  void initState() {
    // DateTime selectedDate = DateTime.now();
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
              initialChildSize: 0.5,
              // Initial percentage of screen occupied by the bottom sheet
              minChildSize: 0.5,
              // Minimum percentage of screen occupied by the bottom sheet
              maxChildSize: 0.75,
              // Maximum percentage of screen occupied by the bottom sheet
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
                  child: Center(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        SizedBox(
                          height: height * 0.87,
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.004,
                                width: width * 0.6,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              SizedBox(
                                height: height * 0.04,
                                child: Text(
                                  'Ride review',
                                  style: robotoBlackProfile,
                                ),
                              ),
                              Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.09),
                                          child: SizedBox(
                                            height: height * 0.1,
                                            width: width * 0.46,
                                            child: const Stack(
                                              children: [
                                                Positioned(
                                                  left: 60,
                                                  child: CircleAvatar(
                                                    radius: 35,
                                                    backgroundImage:
                                                        AssetImage(Images.cab),
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage:
                                                      AssetImage(Images.girl),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.87,
                                          child: Row(
                                            children: [
                                              SizedBox(width: width * 0.2),
                                              SizedBox(
                                                height: height * 0.045,
                                                width: width * 0.25,
                                                child: const Center(
                                                    child: Text(
                                                  'Driver',
                                                  style: robotoMediumBlack,
                                                )),
                                              ),
                                              SizedBox(
                                                height: height * 0.045,
                                                width: width * 0.08,
                                                child: const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 30,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.045,
                                                width: width * 0.08,
                                                child: const Center(
                                                    child: Text(
                                                  '4.3',
                                                  style: robotoMediumBlack,
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                            height: height * 0.1,
                                            width: width * 0.1,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(Images.tofrom),
                                            )),
                                          ),
                                          SizedBox(
                                            height: height * 0.14,
                                            width: width * 0.7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                    height: height * 0.005),
                                                Constant_text_field(
                                                  enabled: false,
                                                  controller: null,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  hintText: 'Railway Satation',
                                                  filled: true,
                                                  validator: Validate_Name,
                                                  height: height * 0.065,
                                                  width: width * 0.7,
                                                  fillColor: Colors.grey[300],
                                                ),
                                                Constant_text_field(
                                                  enabled: false,
                                                  controller: null,
                                                  keyboardType:
                                                      TextInputType.name,
                                                  hintText:
                                                      '2/07,Street name,Area,Code',
                                                  filled: true,
                                                  validator: Validate_Distance,
                                                  height: height * 0.065,
                                                  width: width * 0.7,
                                                  fillColor: Colors.grey[300],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.05,
                                          width: width * 0.87,
                                          child: const Text(
                                            '  Give us your rating',
                                            style: robotoMediumBlack,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.25),
                                          child: SizedBox(
                                            height: height * 0.07,
                                            width: width * 0.87,
                                            child: FivePointedStar(
                                              onChange: (count) {
                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: height * 0.08,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                       setState(() {
                                         changecolor = 0;
                                       });
                                       const newText = 'Good ';
                                       final updatedText = testing.text + newText;
                                       testing.value = testing.value.copyWith(
                                           text: updatedText,
                                           selection: TextSelection.collapsed(offset: updatedText.length)
                                       );
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: width * 0.37,
                                        decoration:  BoxDecoration(
                                          border: Border.all(color: changecolor == 0 ? white :black,),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(15)),
                                            color: changecolor == 0
                                                ?  black
                                                :white,
                                        ),
                                        child:  Center(
                                            child: Text(
                                          'Good',
                                          style: robotoMediumExtraWhite.copyWith(color: changecolor == 0 ? white :black, ),
                                        )),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          changecolor = 1;
                                        });
                                        const newText = 'Bad ';
                                        final updatedText = testing.text + newText;
                                        testing.value = testing.value.copyWith(
                                            text: updatedText,
                                            selection: TextSelection.collapsed(offset: updatedText.length)
                                        );
                                      },
                                      child: Container(
                                        height: height * 0.05,
                                        width: width * 0.37,
                                        decoration:   BoxDecoration(
                                          border: Border.all(color: changecolor == 1 ? white :black,),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(15)),
                                            color: changecolor == 1
                                                ?  black
                                                :white,
                                        ),
                                        child:  Center(
                                            child: Text(
                                          'Bad',
                                          style: robotoMediumExtraWhite.copyWith(color:changecolor == 1
                                              ?  white
                                              :black, ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              SizedBox(
                                height: height * 0.06,
                                width: width * 0.87,
                                child: Constant_text_field(
                                  controller: testing,
                                  keyboardType: TextInputType.name,
                                  hintText: 'Feedback...',
                                  filled: true,
                                  validator: Validate_Feedback,
                                  height: height * 0.06,
                                  width: width * 0.87,
                                  fillColor: Colors.grey[300],
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              CustomButton(
                                onTap: () {},
                                text: 'Submit',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String? Validate_Name(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }

  String? Validate_Distance(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }

  String? Validate_Feedback(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

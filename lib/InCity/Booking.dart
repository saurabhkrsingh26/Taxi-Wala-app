
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/Constant/Constant_textfield/ApiConstant.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class Bokking extends StatefulWidget {
  const Bokking({super.key});

  // final String locationType;

  @override
  State<Bokking> createState() => _BokkingState();
}

class _BokkingState extends State<Bokking> {


  String radius = "30";
  double latitude = 31.5111093;
  double longitude = 74.279664;
  var lat = "0.000";
  var long = "0.000";
  var latt;
  var longg;

  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  _init() {
    _defaultLatLng = const LatLng(20.5937, 78.9629);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(target: _defaultLatLng, zoom: 10.5);
    _gotoUserCurrentPosition();
  }

  Uint8List? marketimages;
  final List<Marker> _markers = [];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List?> loadNetWorkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
    await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  var totallen;
  Widget _getMap() {
    return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _cameraPosition!,
        mapType: MapType.terrain,
        onCameraIdle: () {
          _getAddress(_draggedLatlng);
        },
        onCameraMove: (cameraPosition) {
          _draggedLatlng = cameraPosition.target;
        },
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
    final Uint8List locationIcon = await getImages('assets/googleicon.png', 70);
    setState(() async {
      lat = currentPosition.latitude.toString();
      long = currentPosition.longitude.toString();
      var lats = double.parse(lat);
      var longs = double.parse(long);
      _markers.add(Marker(
        markerId: const MarkerId('0'),
        icon: BitmapDescriptor.fromBytes(locationIcon),
        position: LatLng(lats, longs),
        infoWindow: const InfoWindow(
          title: "userName",
        ),
        draggable: true,
        onDragEnd: ((newPosition) {
        }),
      ));
    });
  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 13.5)));
    await _getAddress(position);
  }

  Future _getAddress(LatLng position) async {
    // _suggestions.clear();
    setState(() {
      latt = position.latitude;
      longg = position.longitude;
    });
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

// fetch live location from the map
  List<dynamic> _suggestions = [];


  Future<Map<String, double>> getLatLngFromPlaceId(
      String placeId, String address) async {
    const apiKey = Apiconst.mapkey;
    final response = await http.get(Uri.parse(
        Apiconst.map_get_lat_long+'$placeId&key=$apiKey'));
    // 'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey'));

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
  
  Widget _buildBody() {
    var height = MediaQuery.of(context).size.height;
    return Stack(children: [

      _getMap(),
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
                // print(latt.toString()+long.toString()+_draggedAddress);
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

  void initState() {
    // DateTime selectedDate = DateTime.now();
    super.initState();
    _init();
  }

bool change= false;
int changecolor=0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //_incrementCounter();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _buildBody(),
            DraggableScrollableSheet(
              initialChildSize: 0.5, // Initial percentage of screen occupied by the bottom sheet
              minChildSize: 0.5, // Minimum percentage of screen occupied by the bottom sheet
              maxChildSize: 0.75, // Maximum percentage of screen occupied by the bottom sheet
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
                     Container(
                       color: ColorConstant.WHITE_BACKGROUND,
                       height:height*0.95,
                         child: Column(
                           children: [
                             Container(
                               height: height*0.18,
                               color: ColorConstant.WHITE_COL0R,
                               child:  Column(
                                 children: [
                                   Container(
                                     height:height*0.005,
                                     width:width*0.5,
                                     decoration: const BoxDecoration(
                                       color: ColorConstant.WHITE_BACKGROUND,
                                       borderRadius: BorderRadius.all(Radius.circular(10)),
                                     ),
                                   ),
                                   const SizedBox(height: 20,),
                                   Row(
                                     children: [
                                       Container(
                                         height:height*0.1,
                                         width:width*0.13,
                                         decoration: const BoxDecoration(
                                             image: DecorationImage(
                                                 image: AssetImage(Images.tofrom)
                                             )
                                         ),
                                       ),
                                       SizedBox(
                                         width:width*0.86,
                                         child: Stack(
                                           children: [
                                             Column(
                                               children: [
                                                 Constant_text_field(
                                                   enabled: false,
                                                   controller: null,
                                                   keyboardType: TextInputType.name,
                                                   hintText: '2/07,Street name,Area,Code',
                                                   filled: true,
                                                   validator: Validate_Distance,
                                                   height:height*0.065,
                                                   width: width*0.7,
                                                   fillColor: Colors.grey[300],
                                                 ),
                                                 Constant_text_field(
                                                   enabled: false,
                                                   controller: null,
                                                   keyboardType: TextInputType.name,
                                                   hintText: 'Set destination',
                                                   filled: true,
                                                   validator: Validate_Name,
                                                   height:height*0.065,
                                                   width: width*0.7,
                                                   fillColor: Colors.grey[300],
                                                 ),
                                               ],
                                             ),
                                             Positioned(
                                               top:height*0.009,
                                               left:width*0.64,
                                               child: Container(
                                                 height:height*0.09,
                                                 width: width*0.134,
                                                 decoration: BoxDecoration(
                                                   color: ColorConstant.WHITE_COL0R,
                                                   borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                   border: Border.all(color: ColorConstant.WHITE_BACKGROUND,width: 0.5),
                                                 ),
                                                 child: const Column(
                                                   children: [
                                                     SizedBox(height: 10,),
                                                     Icon(Icons.watch_later_outlined,color: ColorConstant.Black_COLOR,size: 30,),
                                                     Text('Now',style: robotoBlack,),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(height:height*0.01),
                             Container(
                               height:height*0.04,
                               width:width*0.45,
                               decoration: const BoxDecoration(
                                 color: ColorConstant.Black_COLOR,
                                 borderRadius: BorderRadius.all(Radius.circular(20)),
                               ),
                               child: Row(
                                 children: [
                                   SizedBox(width:width*0.05),
                                   const Icon(Icons.add_to_drive_rounded,color: ColorConstant.WHITE_COL0R,size: 20,),
                                   SizedBox(width:width*0.02),
                                   const Text('Add Coupon',style: robotoMediumExtraWhite,),
                                 ],
                               ),
                             ),
                             SizedBox(height:height*0.01),
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   change=true;
                                   changecolor=1;
                                 });
                               },
                               child:   Card(
                                 color: changecolor==1? Colors.green[200]:Colors.white,
                                 child:SizedBox(
                                   height:height*0.13,
                                   width:width*0.9,
                                   child: Row(
                                     children: [
                                       SizedBox(
                                         height:height*0.14,
                                         width:width*0.29,
                                         child: Column(
                                           children: [
                                             Container(
                                                 height:height*0.09,
                                                 decoration: const BoxDecoration(
                                                     image: DecorationImage(
                                                       fit: BoxFit.cover,
                                                       image: AssetImage(Images.cab),
                                                     )
                                                 )
                                             ),
                                             SizedBox(
                                               height:height*0.022,
                                               child: const Center(child: Text('2 min',style: robotoSmallGrey,)),
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width:width*0.03),
                                       SizedBox(
                                         height:height*0.12,
                                         width: width*0.34,
                                         child: RichText(
                                           text: TextSpan(
                                             text: "\nCab\n",
                                             style:   robotoRegularBlack,
                                             children: const <TextSpan>[
                                               TextSpan(
                                                 text: 'At Your doorstep',
                                                 style:robotoBlack,

                                               ),

                                             ],
                                           ),

                                         ),
                                       ),
                                       SizedBox(
                                         height:height*0.12,
                                         width: width*0.2,
                                         child: RichText(
                                           text: TextSpan(
                                             text: "\n₹ 160\n",
                                             style:   robotoRegularBlack,
                                             children: const <TextSpan>[
                                               TextSpan(
                                                 text: '₹̶ ̶1̶8̶0̶',
                                                 style:robotoMediumBlack,

                                               ),

                                             ],
                                           ),

                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  change=true;
                                  changecolor=2;
                                });
                              },
                              child:  Card(
                                color: changecolor==2? Colors.green[200]:Colors.white,
                                child:SizedBox(
                                  height:height*0.13,
                                  width:width*0.9,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height:height*0.14,
                                        width:width*0.29,
                                        child: Column(
                                          children: [
                                            Container(
                                                height:height*0.09,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(Images.cab),
                                                    )
                                                )
                                            ),
                                            SizedBox(
                                              height:height*0.022,
                                              child: const Center(child: Text('2 min',style: robotoSmallGrey,)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width:width*0.03),
                                      SizedBox(
                                        height:height*0.12,
                                        width: width*0.34,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "\nSedan\n",
                                            style:   robotoRegularBlack,
                                            children: const <TextSpan>[
                                              TextSpan(
                                                text: 'At Your doorstep',
                                                style:robotoBlack,

                                              ),

                                            ],
                                          ),

                                        ),
                                      ),
                                      SizedBox(
                                        height:height*0.12,
                                        width: width*0.2,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "\n₹ 160\n",
                                            style:   robotoRegularBlack,
                                            children: const <TextSpan>[
                                              TextSpan(
                                                text: '₹̶ ̶1̶8̶0̶',
                                                style:robotoMediumBlack,

                                              ),

                                            ],
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   change=true;
                                   changecolor=3;
                                 });
                               },
                               child: Card(
                                 color:  changecolor==3?Colors.green[200]:Colors.white,
                                 child:SizedBox(
                                   height:height*0.13,
                                   width:width*0.9,
                                   child: Row(
                                     children: [
                                       SizedBox(
                                         height:height*0.14,
                                         width:width*0.29,
                                         child: Column(
                                           children: [
                                             Container(
                                                 height:height*0.09,
                                                 decoration: const BoxDecoration(
                                                     image: DecorationImage(
                                                       fit: BoxFit.cover,
                                                       image: AssetImage(Images.cab),
                                                     )
                                                 )
                                             ),
                                             SizedBox(
                                               height:height*0.022,
                                               child: const Center(child: Text('2 min',style: robotoSmallGrey,)),
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width:width*0.03),
                                       SizedBox(
                                         height:height*0.12,
                                         width: width*0.34,
                                         child: RichText(
                                           text: TextSpan(
                                             text: "\nSUV\n",
                                             style:   robotoRegularBlack,
                                             children: const <TextSpan>[
                                               TextSpan(
                                                 text: 'At Your doorstep',
                                                 style:robotoBlack,

                                               ),

                                             ],
                                           ),

                                         ),
                                       ),
                                       SizedBox(
                                         height:height*0.12,
                                         width: width*0.2,
                                         child: RichText(
                                           text: TextSpan(
                                             text: "\n₹ 160\n",
                                             style:   robotoRegularBlack,
                                             children: const <TextSpan>[
                                               TextSpan(
                                                 text: '₹̶ ̶1̶8̶0̶',
                                                 style:robotoMediumBlack,

                                               ),

                                             ],
                                           ),

                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             const SizedBox(height: 15,),
                             SizedBox(
                               height:height*0.06,
                               width: width*0.9,
                               child: Padding(
                                 padding: const EdgeInsets.only(right: 60),
                                 child: Text('Economy',style: robotoBlackProfile,),
                               ),
                             ),
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   change=true;
                                   changecolor=4;
                                 });
                               },
                               child: Card(
                                 color:  changecolor==4?Colors.green[200]:Colors.white,
                                 child:SizedBox(
                                   height:height*0.13,
                                   width:width*0.9,
                                   child: Row(
                                     children: [
                                       SizedBox(
                                         height:height*0.14,
                                         width:width*0.29,
                                         child: Column(
                                           children: [
                                             Container(
                                                 height:height*0.09,
                                                 decoration: const BoxDecoration(
                                                     image: DecorationImage(
                                                       fit: BoxFit.cover,
                                                       image: AssetImage(Images.cab),
                                                     )
                                                 )
                                             ),
                                             SizedBox(
                                               height:height*0.022,
                                               child: const Center(child: Text('2 min',style: robotoSmallGrey,)),
                                             ),
                                           ],
                                         ),
                                       ),
                                       SizedBox(width:width*0.03),
                                       SizedBox(
                                         height:height*0.12,
                                         width: width*0.34,
                                         child: RichText(
                                           text: TextSpan(
                                             text: "\nCab\n",
                                             style:   robotoRegularBlack,
                                             children: const <TextSpan>[
                                               TextSpan(
                                                 text: 'At Your doorstep',
                                                 style:robotoBlack,

                                               ),

                                             ],
                                           ),

                                         ),
                                       ),
                                       SizedBox(
                                         height:height*0.12,
                                         width: width*0.2,
                                         child: RichText(
                                           text: TextSpan(
                                             text: "\n₹ 160\n",
                                             style:   robotoRegularBlack,
                                             children: const <TextSpan>[
                                               TextSpan(
                                                 text: '₹̶ ̶1̶8̶0̶',
                                                 style:robotoMediumBlack,

                                               ),

                                             ],
                                           ),

                                         ),
                                       ),
                                     ],
                                   ),
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
      floatingActionButton: change==true?FloatingActionButton.extended(
        backgroundColor: Colors.black,

        onPressed: () {
          Navigator.pushNamed(context, RoutesName.PaymentIncity);
          setState(() {
            change=false;
          });
      },
        label: const Text('Book now',style: robotoMediumExtraWhite,),

      ):Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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




}
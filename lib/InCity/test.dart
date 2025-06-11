// import 'package:earlyshuttle/Constant/assets.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../../Constant/color.dart';
// import '../../../Constant Widgets/TextStyling/AppBarTitle.dart';
//
// class TrackRideScreen extends StatefulWidget {
//   final String? busId;
//   const TrackRideScreen({super.key, required this.busId});
//   @override
//   _TrackRideScreenState createState() => _TrackRideScreenState();
// }
//
// class _TrackRideScreenState extends State<TrackRideScreen> {
//   late DatabaseReference _databaseReference;
//   late GoogleMapController mapController;
//   LatLng userLocation = const LatLng(0, 0); // Default location
//   late LatLng firebaseLocation;
//   late BitmapDescriptor customMarker;
//
//   @override
//   void initState() {
//     super.initState();
//     _databaseReference = FirebaseDatabase.instance.reference().child(widget.busId??"1848");
//     _getUserLocation();
//     _loadCustomMarker();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         context: context,
//         builder: (BuildContext context) {
//           return LiveTrackingDetailsBottomsheet();
//         },
//       );
//     });
//   }
//
//   void _getUserLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     setState(() {
//       userLocation = LatLng(position.latitude, position.longitude);
//     });
//   }
//
//    Load custom marker image
//   void _loadCustomMarker() async {
//     customMarker = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(size: Size(1, 1)), Graphics.liveTrackingBus
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: ColorConstant.whiteColor,
//           ),
//         ),
//         backgroundColor: ColorConstant.primaryColor,
//         title: HeadingOne(
//             textAlign: TextAlign.left,
//             alignment: Alignment.centerLeft,
//             Title: " Live Tracking"
//         ),
//       ),
//       body: Center(
//         child: StreamBuilder(
//           stream: _databaseReference.onValue,
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData && snapshot.data.snapshot.value != null) {
//               Map<dynamic, dynamic> data = snapshot.data.snapshot.value;
//               firebaseLocation = LatLng(data['latitude'], data['longitude']);
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     flex: 10,
//                     child: GoogleMap(
//                       initialCameraPosition: CameraPosition(
//                         target: firebaseLocation,
//                         zoom: 15.0,
//                       ),
//                       onMapCreated: (GoogleMapController controller) {
//                         mapController = controller;
//                       },
//                       markers: {
//                         Marker(
//                           markerId: const MarkerId('userLocation'),
//                           position: userLocation,
//                           // icon: customMarker,
//                           infoWindow: const InfoWindow(
//                             title: 'User Location',
//                           ),
//                         ),
//                         Marker(
//                           markerId: const MarkerId('firebaseLocation'),
//                           position: firebaseLocation,
//                           icon: customMarker,
//                           infoWindow: const InfoWindow(
//                             title: 'Firebase Location',
//                           ),
//                         ),
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Text("Data from Firebase: ${data.toString()}"),
//                   ),
//                 ],
//               );
//             } else {
//               return const CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // ======================================
// class LiveTrackingDetailsBottomsheet extends StatefulWidget {
//   const LiveTrackingDetailsBottomsheet({super.key});
//
//   @override
//   _LiveTrackingDetailsBottomsheetState createState() => _LiveTrackingDetailsBottomsheetState();
// }
//
// class _LiveTrackingDetailsBottomsheetState extends State<LiveTrackingDetailsBottomsheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.2,
//         minChildSize: 0.05,
//         maxChildSize: 1.0,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return SingleChildScrollView(
//             controller: scrollController,
//             child: Container(
//               padding: EdgeInsets.all(16.0),
//               color: Colors.white,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Text(
//                     'Your Content Goes Here',
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                   SizedBox(height: 20.0),
//                   // Add more content/widgets as needed
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, deprecated_member_use

// import 'dart:convert';
// import 'dart:math';
//
// import 'package:earlyshuttle/User%20Interface/Constant%20Widgets/Other_Features/OpenDialer.dart';
// import 'package:earlyshuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
// import 'package:earlyshuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
// import 'package:earlyshuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// import '../../../../Constant/assets.dart';
// import '../../../../Constant/color.dart';
// import '../../../../Models/Explore_Route/ExploreRoute_Model.dart';
// import '../../../../Models/My_RidesSection/CurrentRides_Model.dart';
// import '../../../../main.dart';
// import '../../../Constant Widgets/Buttons/PrimaryButton.dart';
// import '../../../Constant Widgets/Container/Container_widget.dart';
// import 'package:http/http.dart' as http;
//
// class TrackRideScreen extends StatefulWidget {
//   final ExploreRoute route;
//   final CurrentRideItem? rideData;
//
//   const TrackRideScreen({
//     super.key,
//     required this.route,
//     required this.rideData,
//   });
//
//   @override
//   _TrackRideScreenState createState() => _TrackRideScreenState();
// }
//
// class _TrackRideScreenState extends State<TrackRideScreen> {
//   late GoogleMapController _controller;
//   final Set<Marker> _markers = {};
//   List<LatLng> routeCoordinates = [];
//   LocationData? currentLocation;
//   Location location = Location();
//   Stop? selectedSourseStopDetails;
//   LatLng userLocation = const LatLng(0, 0);
//   List<Stop>? _stopsSelectedForBooking = [];
//
//   bool isLoaded = false;
//   bool isPolylineCreated = false;
//   late DatabaseReference _databaseReference;
//   late BitmapDescriptor customMarker;
//   @override
//   void initState() {
//     super.initState();
//     print("as huuuu");
//     print( _databaseReference = FirebaseDatabase.instance
//         .reference()
//         .child("1943"));
//     _databaseReference = FirebaseDatabase.instance
//         .reference()
//     // .child("1943");
//         .child(widget.rideData!.busScheduleId.toString());
//     _getLocation();
//     _createRouteCoordinates();
//     _loadCustomMarker();
//   }
//
//   void _loadCustomMarker() async {
//     customMarker = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(size: Size(1, 1)), Graphics.liveTrackingBus);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _getLocation() async {
//     try {
//       var userLocation = await location.getLocation();
//       setState(() {
//         currentLocation = userLocation;
//       });
//     } catch (e) {
//       // Handle the error, e.g., log it or show a user-friendly message
//     }
//   }
//
//   void _createRouteCoordinates() async {
//     List<LatLng> coordinates = [];
//     for (int i = 0; i < widget.route.stops.length; i++) {
//       double lat = double.parse(widget.route.stops[i].latitude);
//       double lng = double.parse(widget.route.stops[i].longitude);
//       coordinates.add(LatLng(lat, lng));
//
//       final BitmapDescriptor deviceIcon = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(size: Size(5, 5)),
//         Graphics.allstops,
//       );
//
//       _markers.add(Marker(
//           markerId: MarkerId(widget.route.stops[i].id.toString()),
//           position: LatLng(lat, lng),
//           icon: deviceIcon,
//           infoWindow: InfoWindow(
//             title: widget.route.stops[i].name,
//           ),
//           onTap: () {
//             if (_stopsSelectedForBooking!.length < 2) {
//               setState(() {
//                 _stopsSelectedForBooking!.add(widget.route.stops[i]);
//                 selectedSourseStopDetails = widget.route.stops[i];
//               });
//             } else {}
//           }));
//     }
//
//     routeCoordinates = coordinates;
//     if (routeCoordinates.length >= 2) {
//       await _fetchAndDrawPolyline();
//       _getNearestStop();
//     }
//   }
//
//   Future<void> _fetchAndDrawPolyline() async {
//     List<LatLng> polylineCoordinates = [];
//
//     for (int i = 0; i < routeCoordinates.length - 1; i++) {
//       final start = routeCoordinates[i];
//       final end = routeCoordinates[i + 1];
//
//       final response = await http.get(Uri.parse(
//           'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=driving&key=AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'));
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         final List<dynamic> routes = data['routes'];
//         if (routes.isNotEmpty) {
//           final List<dynamic> legs = routes[0]['legs'];
//           if (legs.isNotEmpty) {
//             final List<dynamic> steps = legs[0]['steps'];
//             if (steps.isNotEmpty) {
//               for (int j = 0; j < steps.length; j++) {
//                 final List<dynamic> points =
//                 decodePolyline(steps[j]['polyline']['points']);
//                 if (points.isNotEmpty) {
//                   polylineCoordinates.addAll(points as Iterable<LatLng>);
//                 }
//               }
//             }
//           }
//         }
//       }
//     }
//
//     setState(() {
//       _polylines.add(
//         Polyline(
//           polylineId: const PolylineId("route"),
//           color: ColorConstant.darkBlue,
//           points: polylineCoordinates,
//           width: 6,
//         ),
//       );
//       isPolylineCreated = true;
//     });
//   }
//
//   List<LatLng> decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     double lat = 0, lng = 0;
//
//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;
//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;
//
//       points.add(LatLng(lat / 1e5, lng / 1e5));
//     }
//     return points;
//   }
//
//   final Set<Polyline> _polylines = {};
//
//   Future<void> _fetchAndDrawPolylinefrom(LatLng originLatLng,
//       LatLng destinationLatLng, String polylineId, Color color) async {
//     final response = await http.get(Uri.parse(
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${originLatLng.latitude},${originLatLng.longitude}&destination=${destinationLatLng.latitude},${destinationLatLng.longitude}&mode=driving&key=AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'));
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final List<dynamic> routes = data['routes'];
//       if (routes.isNotEmpty) {
//         final List<dynamic> legs = routes[0]['legs'];
//         if (legs.isNotEmpty) {
//           final List<dynamic> steps = legs[0]['steps'];
//           if (steps.isNotEmpty) {
//             List<LatLng> polylineCoordinates = [];
//             for (int j = 0; j < steps.length; j++) {
//               final List<dynamic> points =
//               decodePolyline(steps[j]['polyline']['points']);
//               if (points.isNotEmpty) {
//                 polylineCoordinates.addAll(points as Iterable<LatLng>);
//               }
//             }
//             setState(() {
//               _polylines.add(
//                 Polyline(
//                   polylineId: PolylineId(polylineId),
//                   color: color,
//                   points: polylineCoordinates,
//                   width: 5,
//                   patterns: [PatternItem.dot, PatternItem.gap(5)],
//                 ),
//               );
//             });
//           }
//         }
//       }
//     }
//   }
//
//   Future<void> _getNearestStop() async {
//     if (currentLocation == null) {
//       return;
//     }
//     double currentLat = currentLocation!.latitude!;
//     double currentLng = currentLocation!.longitude!;
//
//     LatLng nearestStopLatLng = const LatLng(0, 0); // Initial value
//     double nearestDistance = double.infinity; // Initial value
//
//     for (final stop in widget.route.stops) {
//       double stopLat = double.parse(stop.latitude);
//       double stopLng = double.parse(stop.longitude);
//       double distance =
//       _calculateDistance(currentLat, currentLng, stopLat, stopLng);
//
//       if (distance < nearestDistance) {
//         nearestDistance = distance;
//         nearestStopLatLng = LatLng(stopLat, stopLng);
//       }
//     }
//     await _fetchAndDrawPolylinefrom(
//       LatLng(currentLat, currentLng),
//       nearestStopLatLng,
//       "current_to_nearest",
//       Colors.purpleAccent,
//     );
//
//     setState(() {
//       _nearestStopMarker = null;
//       _currentLocationMarker = null;
//       _nearestStopMarker = Marker(
//         markerId: const MarkerId('nearest_stop'),
//         position: nearestStopLatLng,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         infoWindow: const InfoWindow(
//           title: 'Nearest Stop',
//         ),
//       );
//
//       _currentLocationMarker = Marker(
//         markerId: const MarkerId('current_location'),
//         position: LatLng(currentLat, currentLng),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         infoWindow: const InfoWindow(
//           title: 'Your Location',
//         ),
//       );
//
//       // Set the camera position to your current location
//       _cameraPosition = CameraPosition(
//         target: LatLng(currentLat, currentLng),
//         zoom: 18.0,
//       );
//     });
//   }
//
//   Marker? _nearestStopMarker;
//   Marker? _currentLocationMarker;
//   Marker? _liveBusPositoion;
//   CameraPosition? _cameraPosition;
//
//   double _calculateDistance(
//       double lat1, double lon1, double lat2, double lon2) {
//     const double earthRadius = 6371; // Radius of the Earth in kilometers
//     double dLat = _degreesToRadians(lat2 - lat1);
//     double dLon = _degreesToRadians(lon2 - lon1);
//     double a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(_degreesToRadians(lat1)) *
//             cos(_degreesToRadians(lat2)) *
//             sin(dLon / 2) *
//             sin(dLon / 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     double distance = earthRadius * c;
//     return distance;
//   }
//
//   double _degreesToRadians(double degrees) {
//     return degrees * pi / 180;
//   }
//
//   Polyline? _currentToNearestPolyline;
//
//   void clearList() {
//     setState(() {
//       _stopsSelectedForBooking = [];
//     });
//   }
//
//   Future<void> moveCameraIfNeeded() async {
//     LatLngBounds bounds = await _controller.getVisibleRegion();
//     if (!bounds.contains(firebaseLocation)) {
//       _controller.animateCamera(
//         CameraUpdate.newLatLng(firebaseLocation),
//       );
//     }
//   }
//
//   late LatLng firebaseLocation;
//   late GoogleMapController mapController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: ColorConstant.whiteColor,
//           ),
//         ),
//         title: HeadingOne(
//           Title: "Live Tracking",
//         ),
//         backgroundColor: ColorConstant.primaryColor,
//         actions: [
//           isPolylineCreated == false
//               ? const SizedBox()
//               : Tooltip(
//             message: "Get your location",
//             child: PrimaryButton(
//               inCol: false,
//               onTap: () {
//                 _controller.animateCamera(
//                   CameraUpdate.newCameraPosition(_cameraPosition!),
//                 );
//               },
//               color: Colors.transparent,
//               width: width / 8,
//               icon: Icons.location_history,
//               iconSize: width / 12,
//             ),
//           ),
//           const SizedBox(width: 8,),
//           isPolylineCreated == false
//               ? const SizedBox()
//               : Tooltip(
//             message: "Get bus live location",
//             child: PrimaryButton(
//               inCol: false,
//               onTap: () {
//                 _controller.animateCamera(
//                   CameraUpdate.newLatLng(firebaseLocation),
//                 );
//               },
//               color: Colors.transparent,
//               width: width / 8,
//               icon: Icons.bus_alert,
//               iconSize: width / 12,
//             ),
//           )
//         ],
//       ),
//       body: isPolylineCreated == true
//           ? StreamBuilder(
//         stream: _databaseReference.onValue,
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData && snapshot.data.snapshot.value != null) {
//             Map<dynamic, dynamic> data = snapshot.data.snapshot.value;
//             firebaseLocation =
//                 LatLng(data['latitude'], data['longitude']);
//             _liveBusPositoion = Marker(
//               markerId: const MarkerId('firebaseLocation'),
//               position: firebaseLocation,
//               icon: customMarker,
//               infoWindow: const InfoWindow(
//                 title: 'Shuttle live location',
//               ),
//             );
//             moveCameraIfNeeded();
//             // _controller.animateCamera(
//             //   CameraUpdate.newLatLng(firebaseLocation));
//             return GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: firebaseLocation,
//                 zoom: 15.0,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 setState(() {
//                   _controller = controller;
//                   _createRouteCoordinates();
//                 });
//               },
//               markers: _markers.toSet()
//                 ..addAll(_nearestStopMarker != null
//                     ? [_nearestStopMarker!]
//                     : [])
//                 ..addAll(_currentLocationMarker != null
//                     ? [_currentLocationMarker!]
//                     : [])
//                 ..addAll(_liveBusPositoion != null
//                     ? [_liveBusPositoion!]
//                     : []),
//               polylines: _polylines.toSet()
//                 ..addAll(_currentToNearestPolyline != null
//                     ? [_currentToNearestPolyline!]
//                     : []),
//             );
//           }
//           if(snapshot.hasData && snapshot.data.snapshot.value == null){
//             Future.delayed(const Duration(seconds: 5),(){
//               Navigator.of(context).pop();
//             });
//             return SubTitle_Text(Title: "Bus has not started from source location",);
//           }
//           else {
//             return SubTitle_Text(Title: "Loading data",);
//           }
//         },
//       )
//           : Stack(
//         alignment: Alignment.center,
//         children: [
//           GoogleMap(
//             zoomControlsEnabled: false,
//             onMapCreated: (controller) {
//               setState(() {
//                 _controller = controller;
//                 _createRouteCoordinates();
//               });
//             },
//             initialCameraPosition: const CameraPosition(
//               target: LatLng(0, 0),
//               zoom: 15.0,
//             ),
//           ),
//           CustomContainer(
//               height: height,
//               width: width,
//               color: ColorConstant.darkBlackColor.withOpacity(0.5),
//               alignment: FractionalOffset.center,
//               child: CustomContainer(
//                 width: width / 4.5,
//                 height: width / 4.5,
//                 padding: const EdgeInsets.all(20),
//                 border: Border.all(
//                     width: 1, color: ColorConstant.darkBlackColor),
//                 color: ColorConstant.whiteColor.withOpacity(0.9),
//                 child: CircularProgressIndicator(
//                   color: ColorConstant.blueColor,
//                 ),
//               ))
//         ],
//       ),
//       bottomSheet: isPolylineCreated == true
//           ? CustomContainer(
//         border: Border.all(color: ColorConstant.greyColor),
//         borderRadius: const BorderRadius.only(
//           topRight: Radius.circular(15),
//           topLeft: Radius.circular(15),
//         ),
//         gradient: LinearGradient(
//           begin: Alignment.bottomCenter,
//           end: AlignmentDirectional.topCenter,
//           colors: [
//             ColorConstant.gradientLightblue,
//             ColorConstant.gradientLightGreen,
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         margin: const EdgeInsets.only(bottom: 0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TitleStyle(
//               Title: "Ride Details",
//               textColor: ColorConstant.darkBlackColor,
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     SubTitle_Text(
//                       Title: "Order Id: ",
//                       textColor: ColorConstant.greyColor,
//                     ),
//                     SubTitle_Text(
//                       Title: widget.rideData!.id.toString(),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     SubTitle_Text(
//                       Title: "Otp: ",
//                       textColor: ColorConstant.darkBlue,
//                     ),
//                     SubTitle_Text(
//                       Title: widget.rideData!.otp.toString(),
//                       textColor: ColorConstant.darkBlue,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Row(
//               children: [
//                 SubTitle_Text(
//                   Title: "From: ",
//                   textColor: ColorConstant.greyColor,
//                 ),
//                 SubTitle_Text(
//                   Title: widget.rideData!.pickupName,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 SubTitle_Text(
//                   Title: "To: ",
//                   textColor: ColorConstant.greyColor,
//                 ),
//                 SubTitle_Text(
//                   Title: widget.rideData!.dropName,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     SubTitle_Text(
//                       Title: "Date: ",
//                       textColor: ColorConstant.greyColor,
//                     ),
//                     SubTitle_Text(
//                       Title: widget.rideData!.pickupDate,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     SubTitle_Text(
//                       Title: "Time: ",
//                       textColor: ColorConstant.greyColor,
//                     ),
//                     SubTitle_Text(
//                       Title: widget.rideData!.pickupTime,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     SubTitle_Text(
//                       Title: "Driver name: ",
//                       textColor: ColorConstant.greyColor,
//                     ),
//                     SubTitle_Text(
//                       Title: widget.rideData!.driverName,
//                     ),
//                   ],
//                 ),
//                 PrimaryButton(
//                   onTap: () {
//                     MakeCall.openDialPad(
//                         widget.rideData!.driverNumber.toString());
//                   },
//                   // border: Border.all(),
//                   color: ColorConstant.darkBlue,
//                   borderRadius: BorderRadius.circular(25),
//                   height: 30,
//                   width: width / 3,
//                   inCol: false,
//                   icon: Icons.call,
//                   iconSize: 18,
//                   Label: "Call driver",
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//           ],
//         ),
//       )
//           : const SizedBox(),
//     );
//   }
// }
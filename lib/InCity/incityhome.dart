// // ignore_for_file: prefer_typing_uninitialized_variables
//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
// import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
// import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
// import 'package:taxiwala/Constant/assetsConstant.dart';
// import 'package:taxiwala/Constant/fontstyle.dart';
// import 'package:taxiwala/HomeDirectory/homepage.dart';
// import 'package:taxiwala/Route/RouteNames.dart';
// import 'package:http/http.dart' as http;
// import 'package:taxiwala/model/carTypeModel.dart';
// import 'package:taxiwala/res/provider/carBookingProvider.dart';
// import 'package:taxiwala/res/provider/carTypeProvider.dart';
//
// class InCityHome extends StatefulWidget {
//   const InCityHome({super.key});
//
//   @override
//   State<InCityHome> createState() => _InCityHomeState();
// }
//
// class _InCityHomeState extends State<InCityHome> {
//   final TextEditingController from = TextEditingController();
//   final TextEditingController to = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     myReviewData();
//     Future.delayed(Duration.zero, () {
//       Map<String, dynamic>? args =
//       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//       if (args != null && args.containsKey('LocationData')) {
//         String locationName = args['LocationData']['locationName'];
//         String conlat = args['LocationData']['Latitude'];
//         String conlong = args['LocationData']['longitude'];
//         from.text = locationName;
//         fromlat = double.parse(conlat);
//         fromlong = double.parse(conlong);
//       }
//     });
//   }
//   Widget bookCar() {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     int changecolor = 0;
//     final carBokkingProvider = Provider.of<CarBookingProvider>(context);
//     return Column(
//       children: [
//         const Divider(
//           color: Colors.transparent,
//         ),
//         Container(
//           width: width * 0.45,
//           decoration: const BoxDecoration(
//             color: ColorConstant.Black_COLOR,
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           child: Row(
//             children: [
//               SizedBox(width: width * 0.05),
//               const Icon(
//                 Icons.add_to_drive_rounded,
//                 color: ColorConstant.WHITE_COL0R,
//                 size: 20,
//               ),
//               SizedBox(width: width * 0.02),
//               const Text(
//                 'Add Coupon',
//                 style: robotoMediumExtraWhite,
//               ),
//             ],
//           ),
//         ),
//         const Divider(
//           color: Colors.transparent,
//         ),
//         ListView.builder(
//             shrinkWrap: true,
//             physics: const BouncingScrollPhysics(),
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               final calculatedPrice = calculatedDistance != null
//                   ? int.parse(data[index].price_km.toString()) *
//                       calculatedDistance
//                   : null;
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     changecolor = 1;
//                   });
//                 },
//                 child: Card(
//                   color: changecolor == 1 ? Colors.green[200] : Colors.white,
//                   child: ExpansionTile(
//                     title: SizedBox(
//                       width: width * 0.9,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             width: width * 0.2,
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: height * 0.09,
//                                   child: Image.network(
//                                     data[index].image.toString(),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   child: Center(
//                                       child: Text('2 min',
//                                           style: robotoSmallGrey)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: width * 0.34,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data[index].car_type.toString(),
//                                   style: robotoRegularBlack,
//                                 ),
//                                 const Text(
//                                   "At Your doorstep",
//                                   style: robotoBlack,
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: width * 0.18,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   calculatedPrice == null
//                                       ? "0"
//                                       : "₹${calculatedPrice.toStringAsFixed(0)}",
//                                   style:
//                                       robotoRegularBlack.copyWith(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     children: <Widget>[
//                       ListTile(
//                           title: ColorButton(
//                         onTap: () {
//                           carBokkingProvider.carBooking(context, fromlat.toString(), fromlong.toString(), tolat.toString(), tolong.toString(), data[index].id.toString(), calculatedPrice!.toStringAsFixed(1), calculatedDistance.toString());
//                         },
//                         text: 'Book',
//                         btnColor: ColorConstant.Green_BACKGROUND,
//                         textColor: ColorConstant.WHITE_COL0R,
//                       )),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//         SizedBox(
//           height: height * 0.1,
//         )
//       ],
//     );
//   }
//   Widget usedtofrom() {
//     var width = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         const Divider(
//           color: Colors.transparent,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             const Icon(
//               Icons.home_outlined,
//               size: 30,
//             ),
//             const Text(
//               '   Home',
//               style: robotoBlack,
//             ),
//             SizedBox(
//               width: width * 0.02,
//             ),
//             const Icon(
//               Icons.card_travel,
//               size: 30,
//             ),
//             const Text(
//               '   Work',
//               style: robotoBlack,
//             ),
//             SizedBox(
//               width: width * 0.02,
//             ),
//             const Icon(
//               Icons.star_border,
//               size: 30,
//             ),
//             const Text(
//               '   Favourites',
//               style: robotoBlack,
//             ),
//           ],
//         ),
//         const Divider(
//           color: Colors.transparent,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             SizedBox(
//               width: width * 0.15,
//               child: const Column(
//                 children: [
//                   Icon(
//                     Icons.location_on_outlined,
//                     size: 30,
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Icon(
//                     Icons.location_on_outlined,
//                     size: 30,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: width * 0.76,
//               child: const Column(
//                 children: [
//                   Text(
//                     'Seetharampuram,vijayawada,Andhra\nPradesh',
//                     style: robotoSmallGrey,
//                   ),
//                   Divider(),
//                   Divider(
//                     color: Colors.transparent,
//                   ),
//                   Text(
//                     'Seetharampuram,vijayawada,Andhra\nPradesh',
//                     style: robotoSmallGrey,
//                   ),
//                   Divider(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//   CarTypeProvider carTypeProvider = CarTypeProvider();
//   List<CarTypeModel> data = [];
//   Future<void> myReviewData() async {
//     // cartItems.clear();
//     try {
//       List<CarTypeModel> carList = await carTypeProvider.carType();
//       setState(() {
//         data = carList;
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching reviews data: $e');
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return ListView(
//       // shrinkWrap: true,
//       physics: const BouncingScrollPhysics(),
//       children: [
//         const Divider(
//           color: Colors.transparent,
//         ),
//         Row(
//           children: [
//             Container(
//               height: height * 0.13,
//               width: width * 0.13,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(image: AssetImage(Images.tofrom))),
//             ),
//             SizedBox(
//               width: width * 0.85,
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           _selectLocation("from");
//                         },
//                         child: Constant_text_field(
//                           enabled: false,
//                           controller: from,
//                           keyboardType: TextInputType.name,
//                           hintText: '2/07,Street name,Area,Code',
//                           filled: true,
//                           height: height * 0.065,
//                           width: width * 0.7,
//                           fillColor: Colors.grey[300],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           _selectLocation("to");
//                         },
//                         child: Constant_text_field(
//                           enabled: false,
//                           controller: to,
//                           keyboardType: TextInputType.name,
//                           hintText: 'Set destination',
//                           filled: true,
//                           height: height * 0.065,
//                           width: width * 0.7,
//                           fillColor: Colors.grey[300],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     top: height * 0.008,
//                     left: width * 0.65,
//                     child: Container(
//                       height: height * 0.09,
//                       width: width * 0.13,
//                       decoration: BoxDecoration(
//                         color: ColorConstant.WHITE_COL0R,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(10)),
//                         border: Border.all(
//                             color: ColorConstant.WHITE_BACKGROUND, width: 0.5),
//                       ),
//                       child: const Column(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Icon(
//                             Icons.watch_later_outlined,
//                             color: ColorConstant.Black_COLOR,
//                             size: 30,
//                           ),
//                           Text(
//                             'Now',
//                             style: robotoBlack,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         from.text.isNotEmpty && to.text.isNotEmpty ? bookCar() : usedtofrom(),
//       ],
//     );
//   }
//   var fromlat, fromlong, tolat, tolong;
//   void _selectLocation(String locationType) async {
//     PolylineDraw polylineDraw = PolylineDraw();
//     final selectedLocation = await Navigator.pushNamed(
//         context, RoutesName.PickupLocation,
//         arguments: locationType);
//     if (selectedLocation != null && selectedLocation is Map<String, dynamic>) {
//       if (locationType == 'from') {
//         setState(() {
//           from.text = selectedLocation['locationName'];
//           fromlat = selectedLocation['latitude'];
//           fromlong = selectedLocation['longitude'];
//           if (routeCoordinates.length >= 2) {
//             routeCoordinates.removeAt(0);
//           }
//           routeCoordinates.add(LatLng(fromlat, fromlong));
//         });
//       } else if (locationType == 'to') {
//         setState(() {
//           to.text = selectedLocation['locationName'];
//           tolat = selectedLocation['latitude'];
//           tolong = selectedLocation['longitude'];
//           if (routeCoordinates.length >= 2) {
//             routeCoordinates.removeAt(1);
//           }
//           routeCoordinates.add(LatLng(tolat, tolong));
//         });
//       }
//        if (from.text.isNotEmpty || to.text.isNotEmpty) {
//         calculateDistance(fromlat, fromlong, tolat, tolong);
//          if (routeCoordinates.length >= 2) {
//            setState(() {
//              // polyLines.clear();
//            });
//            await polylineDraw.fetchAndDrawPolyline();
//            setState(() {
//            });
//          }
//       }
//     }
//   }
//   var calculatedDistance;
//   Future<void> calculateDistance(double fromlat, double fromlong, double tolat, double tolong) async {
//     const String apiKey = "AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM"; // Replace with your Google Maps API key
//     final String url =
//         "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$fromlat,$fromlong&destinations=$tolat,$tolong&key=$apiKey&mode=car";
//     try {
//       http.Response response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         Map<String, dynamic> jsonData = json.decode(response.body);
//         double distance =
//             (jsonData['rows'][0]['elements'][0]['distance']['value'] as int) * 0.001;
//         setState(() {
//           calculatedDistance = distance;
//         });
//       } else {
//         if (kDebugMode) {
//           print("API Request Failed with status code: ${response.statusCode}");
//         }
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("Error: $error");
//       }
//     }
//   }
// }

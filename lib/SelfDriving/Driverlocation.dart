import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class driverLocation extends StatefulWidget {
  const driverLocation({super.key});

  @override
  State<driverLocation> createState() => _driverLocationState();
}
class _driverLocationState extends State<driverLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _currentPosition = const CameraPosition(
    target: LatLng(13.0827, 80.2707),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: _currentPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete();
              },
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            // Initial percentage of screen occupied by the bottom sheet
            minChildSize: 0.7,
            // Minimum percentage of screen occupied by the bottom sheet
            maxChildSize: 0.75,
            // Maximum percentage of screen occupied by the bottom sheet
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
                    Center(
                      child: Container(
                        height: height * 0.006,
                        width: width * 0.44,
                        decoration: const BoxDecoration(
                          color: ColorConstant.WHITE_BACKGROUND,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height * 0.015),
                        SizedBox(
                          height: height * 0.15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                color: ColorConstant.WHITE_COL0R,
                                child: SizedBox(
                                  height: height * 0.14,
                                  width: width * 0.44,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "  273 Km",
                                        style: robotoBlackProfile,
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: "\n\nDistance Covered",
                                            style: robotoSmallGrey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: ColorConstant.WHITE_COL0R,
                                child: SizedBox(
                                  height: height * 0.14,
                                  width: width * 0.44,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: "18:58:12\n",
                                        style: robotoBlackProfile,
                                        children: const <TextSpan>[
                                          TextSpan(
                                            text: "\n        Time",
                                            style: robotoSmallGrey,

                                          ),

                                        ],
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.06,
                          width: width * 0.42,
                          decoration: const BoxDecoration(
                            color: ColorConstant.Black_COLOR,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(child: Text(
                              'Navigate car', style: robotoMediumExtraWhite)),
                        ),
                        Container(
                          height: height * 0.06,
                          width: width * 0.42,
                          decoration: const BoxDecoration(
                            color: ColorConstant.Black_COLOR,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(child: Text(
                              'Navigate host', style: robotoMediumExtraWhite)),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.15,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.06),
                                            child: const Text('TN78CA9571',
                                              style: robotoMediumBlack,),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.06),
                                            child: const Text('Red Swift',
                                              style: robotoSmallGrey,),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: width * 0.06),
                                            child: const Text(
                                              'Host name', style: robotoBlack,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: height * 0.01),
                                    SizedBox(
                                      width: width * 0.4,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.17),
                                            child: const CircleAvatar(
                                              radius: 35,
                                              backgroundImage: AssetImage(
                                                  Images.cab),
                                              backgroundColor: ColorConstant
                                                  .WHITE_BACKGROUND,
                                            ),
                                          ),
                                          const Positioned(
                                              left: 0,
                                              child: CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: AssetImage(
                                                      Images.girl)
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.08,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        height: height * 0.07,
                                        width: width * 0.13,
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
                                    const SizedBox(width: 10,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Constant_text_field(
                                        controller: null,
                                        keyboardType: TextInputType.name,
                                        hintText: 'Message...',
                                        filled: true,
                                        validator: Validate_Name,
                                        height: height * 0.08,
                                        width: width * 0.65,
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
                    SizedBox(
                      height: 80,
                      child: Center(
                        child: ColorButton(onTap: () {
                          Navigator.pushNamed(context, RoutesName.OTPpages);
                        },
                          text: 'End ride',
                          btnColor: ColorConstant.Black_COLOR,
                          textColor: ColorConstant.WHITE_COL0R,),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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

  void main() {
    runApp(const MaterialApp(
      home: driverLocation(),
    ));
  }
}

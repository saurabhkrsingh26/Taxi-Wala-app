import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

void main() {
  runApp(const MaterialApp(
    home: SettingPrefference(),
  ));
}

class SettingPrefference extends StatefulWidget {
  const SettingPrefference({super.key});

  @override
  State<SettingPrefference> createState() => _SettingPrefferenceState();
}

class _SettingPrefferenceState extends State<SettingPrefference> {
  bool status = false;
  bool statusinvoice = false;
  bool SMSinvoice = false;
  bool SMSoffers = false;
  bool Whatsapp = false;
  bool notifaction = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Preferences',style: robotoBlackProfile),),
      ),
      body: Container(
        height: height*0.9,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.WHITE_BACKGROUND,
        child: Column(
          children: [
            SizedBox(height:height*0.01,),
            Card(
          color: ColorConstant.WHITE_COL0R,
          child:SizedBox(
            height: height*0.18,
            width: width*0.93,
            child: Column(
                children: [
                  SizedBox(
                    height: height*0.05,
                    child: Center(child: Padding(
                      padding: EdgeInsets.only(right:height*0.32),
                      child: const Text('Email',style: robotolargeBlack),
                    )),
                  ),
                  SizedBox(
                    height: height*0.05,
                    child: Row(
                      children: [
                        SizedBox(
                          height: height*0.05,
                          width: width*0.73,
                          child: Padding(
                            padding:EdgeInsets.only(left:width*0.05),
                            child: const Text('Allow emails for promotions and\noffer',style: robotoBlack,),
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.only(right:width*0.04),
                          child: FlutterSwitch(
                           width: width*0.1,
                            height: height*0.023,
                            toggleSize:height*0.014,
                            value: status,
                            borderRadius: 20.0,
                            padding: 2.0,
                            toggleColor: ColorConstant.Black_COLOR,
                            switchBorder: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            toggleBorder: Border.all(
                              color: ColorConstant.Black_COLOR,
                              width: 20.0,
                            ),
                            activeColor: ColorConstant.RED_COLOR,
                            inactiveColor: ColorConstant.WHITE_COL0R,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:height*0.02),
                  SizedBox(
                    height: height*0.05,
                    child: Row(
                      children: [
                        SizedBox(
                          height: height*0.05,
                          width: width*0.73,
                          child: Padding(
                            padding:EdgeInsets.only(left:width*0.05),
                            child: const Text('Allow email for invoice',style: robotoBlack,),
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.only(right:width*0.04),
                          child: FlutterSwitch(
                            width: width*0.1,
                            height: height*0.023,
                            toggleSize:height*0.014,
                            value: statusinvoice,
                            borderRadius: 20.0,
                            padding: 2.0,
                            toggleColor: ColorConstant.Black_COLOR,
                            switchBorder: Border.all(
                              color: Colors.black,
                              width: 2.0,
                            ),
                            toggleBorder: Border.all(
                              color: ColorConstant.Black_COLOR,
                              width: 20.0,
                            ),
                            activeColor: Colors.green,
                            inactiveColor: ColorConstant.WHITE_COL0R,
                            onToggle: (val) {
                              setState(() {
                                statusinvoice = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ),
            ),
            ),
            SizedBox(height: height*0.02,),
            Card(
              color: ColorConstant.WHITE_COL0R,
              child:SizedBox(
                height: height*0.28,
                width: width*0.93,
                child: Column(
                  children: [
                    SizedBox(
                      height:height*0.06,
                      child: Center(child: Padding(
                        padding:EdgeInsets.only(right:width*0.35),
                        child: const Text('SMS & WhatsApp',style: robotolargeBlack),
                      )),
                    ),
                    SizedBox(height: height*0.015),
                    SizedBox(
                      height: height*0.05,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height*0.05,
                            width: width*0.73,
                            child: Padding(
                              padding:EdgeInsets.only(left:width*0.05),
                              child: const Text('Allow SMS for invoice',style: robotoBlack,),
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.only(right:width*0.04),
                            child: FlutterSwitch(
                              width: width*0.1,
                              height: height*0.023,
                              toggleSize:height*0.014,
                              value: SMSinvoice,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: ColorConstant.Black_COLOR,
                              switchBorder: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              toggleBorder: Border.all(
                                color: ColorConstant.Black_COLOR,
                                width: 20.0,
                              ),
                              activeColor: ColorConstant.RED_COLOR,
                              inactiveColor: ColorConstant.WHITE_COL0R,
                              onToggle: (val) {
                                setState(() {
                                  SMSinvoice = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    SizedBox(
                      height: height*0.05,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height*0.05,
                            width: width*0.73,
                            child: Padding(
                              padding:EdgeInsets.only(left:width*0.05),
                              child: const Text('Allow Promotional SMS offers',style: robotoBlack,),
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.only(right:width*0.04),
                            child: FlutterSwitch(
                              width: width*0.1,
                              height: height*0.023,
                              toggleSize:height*0.014,
                              value: SMSoffers,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: ColorConstant.Black_COLOR,
                              switchBorder: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              toggleBorder: Border.all(
                                color: ColorConstant.Black_COLOR,
                                width: 20.0,
                              ),
                              activeColor: Colors.green,
                              inactiveColor: ColorConstant.WHITE_COL0R,
                              onToggle: (val) {
                                setState(() {
                                  SMSoffers = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.015),
                    SizedBox(
                      height: height*0.05,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height*0.05,
                            width: width*0.73,
                            child: Padding(
                              padding: EdgeInsets.only(left:width*0.05),
                              child: const Text('Allow update to be sent on\nWhatsapp',style: robotoBlack,),
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.only(right:width*0.04),
                            child: FlutterSwitch(
                              width: width*0.1,
                              height: height*0.023,
                              toggleSize:height*0.014,
                              value: Whatsapp,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: ColorConstant.Black_COLOR,
                              switchBorder: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              toggleBorder: Border.all(
                                color: ColorConstant.Black_COLOR,
                                width: 20.0,
                              ),
                              activeColor: Colors.blueAccent,
                              inactiveColor: ColorConstant.WHITE_COL0R,
                              onToggle: (val) {
                                setState(() {
                                  Whatsapp = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.015),
            Card(
              color: ColorConstant.WHITE_COL0R,
              child:SizedBox(
                height: height*0.14,
                width: width*0.93,
                child: Column(
                  children: [
                    SizedBox(height: height*0.015),
                    SizedBox(
                    height: height*0.05,
                    width: width*0.73,
                    child: Padding(
                      padding: EdgeInsets.only(left:width*0.009),
                        child: const Text('Push notifications',style: robotolargeBlack),
                      )),
                    SizedBox(height: height*0.015),
                    SizedBox(
                      height: height*0.05,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 260,
                            child: Padding(
                              padding:EdgeInsets.only(left:width*0.05),
                              child: const Text('Allow mobile push notification',style: robotoBlack,),
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.only(right:width*0.04),
                            child: FlutterSwitch(
                              width: width*0.1,
                              height: height*0.023,
                              toggleSize:height*0.014,
                              value: notifaction,
                              borderRadius: 20.0,
                              padding: 2.0,
                              toggleColor: ColorConstant.Black_COLOR,
                              switchBorder: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              toggleBorder: Border.all(
                                color: ColorConstant.Black_COLOR,
                                width: 20.0,
                              ),
                              activeColor: ColorConstant.RED_COLOR,
                              inactiveColor: ColorConstant.WHITE_COL0R,
                              onToggle: (val) {
                                setState(() {
                                  notifaction = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

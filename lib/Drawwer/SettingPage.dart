// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/res/provider/launcher.dart';
import 'package:taxiwala/res/provider/whatsapp_view_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whatsappView(context);
    // WhatsappViewProvider whatsappViewProvider = WhatsappViewProvider();
  }
  @override
  Widget build(BuildContext context) {
    WhatsappViewProvider whatsappViewProvider = WhatsappViewProvider();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Settings', style: robotoBlackProfile),),
      ),
      body: ListView(
        children: [
          Container(
            height: height * 0.9,
            width: MediaQuery
                .of(context)
                .size
                .width,
            color: const Color(0xffE5E6E8),
            child: Column(
              children: [
                SizedBox(height: height * 0.03),
                SizedBox(
                  height: height * 0.05,
                  child: Padding(
                    padding: EdgeInsets.only(right: width * 0.6),
                    child: const Text('General', style: robotolargeBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child: SizedBox(
                    height: height * 0.5,
                    width: width * 0.89,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.drawerpage);
                          },
                          child: SizedBox(
                            height: height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorConstant.Black_COLOR
                                    ),
                                    child: const Icon(Icons.person,
                                      color: ColorConstant.WHITE_COL0R,
                                      size: 30,),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                    width: width * 0.45,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          left: width * 0.05),
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Profile\n",
                                          style: robotoBold,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '2547098180',
                                              style: robotoBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey[300],),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.SettingFavoutrites);
                          },
                          child: SizedBox(
                            height: height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorConstant.Black_COLOR
                                    ),
                                    child: const Icon(Icons.favorite,
                                      color: ColorConstant.WHITE_COL0R,
                                      size: 30,),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                    width: width * 0.6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          left: width * 0.05),
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Favorites\n",
                                          style: robotoBold,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'manage Favourite location',
                                              style: robotoBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey[300],),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.SettingPrefference);
                          },
                          child: SizedBox(
                            height: height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorConstant.Black_COLOR
                                    ),
                                    child: const Icon(Icons.calendar_month,
                                      color: ColorConstant.WHITE_COL0R,
                                      size: 30,),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                    width: width * 0.6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          left: width * 0.05),
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Preference\n",
                                          style: robotoBold,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Manage Preference',
                                              style: robotoBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey[300],),
                        InkWell(
                          onTap: () {

                            // Navigator.pushNamed(context, RoutesName.SettingLanguage);
                          },
                          child: SizedBox(
                            height: height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorConstant.Black_COLOR
                                    ),
                                    child: const Icon(Icons.language,
                                      color: ColorConstant.WHITE_COL0R,
                                      size: 30,),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                    width: width * 0.6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          left: width * 0.05),
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "App Language\n",
                                          style: robotoBold,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'English',
                                              style: robotoBlack,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey[300],),
                        SizedBox(
                          height: height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.15,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorConstant.Black_COLOR
                                  ),
                                  child: const Icon(Icons.u_turn_right,
                                    color: ColorConstant.WHITE_COL0R,
                                    size: 30,),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                  width: width * 0.6,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.02, left: width * 0.05),
                                    child: RichText(
                                      text: const TextSpan(
                                        text: "Add Shortcuts\n",
                                        style: robotoBold,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Create shortcuts on launcher',
                                            style: robotoBlack,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02,),
                SizedBox(
                  height: height * 0.04,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 240),
                    child: Text('Others', style: robotolargeBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child: SizedBox(
                    height: height * 0.2,
                    width: width * 0.9,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.03),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.15,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorConstant.Black_COLOR
                                  ),
                                  child: const Icon(Icons.manage_accounts_sharp,
                                    color: ColorConstant.WHITE_COL0R,
                                    size: 30,),
                                ),
                                SizedBox(
                                  height: height * 0.08,
                                  width: width * 0.6,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: height * 0.02, left: width * 0.05),
                                    child: RichText(
                                      text: const TextSpan(
                                        text: "About\n",
                                        style: robotoBold,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '7.23.0',
                                            style: robotoBlack,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey[300],),
                    InkWell(
                      onTap: () {
                        Launcher.openwhatsapp(context);
                      },
                          child: SizedBox(
                            height: height * 0.08,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.06,
                                    width: width * 0.15,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorConstant.Black_COLOR
                                    ),
                                    child: const Icon(Icons.support_agent,
                                      color: ColorConstant.WHITE_COL0R,
                                      size: 30,),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                    width: width * 0.6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: height * 0.02,
                                          left: width * 0.05),
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Customer Support\n",
                                          style: robotoBold,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Customer service available',
                                              style: robotoBlack,
                                            ),
                                          ],
                                        ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // void _sendMessageOnWhatsApp() async {
  //   try {
  //     // Encode the message
  //     // String encodedMessage = Uri.encodeFull(message);
  //
  //     // Launch WhatsApp using the URL scheme
  //     String whatsappUrl = "whatsapp://send?phone=+1234567890&text=Hello";
  //
  //     // Check if WhatsApp is installed on the device
  //     if (await canLaunch(whatsappUrl)) {
  //       await launch(whatsappUrl);
  //     } else {
  //       // If WhatsApp is not installed, show an error message
  //       throw 'WhatsApp is not installed';
  //     }
  //   } catch (e) {
  //     // Handle any exceptions
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('An error occurred: $e'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

}

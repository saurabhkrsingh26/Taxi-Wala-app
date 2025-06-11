// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class myridesinfo extends StatefulWidget {
  const myridesinfo({super.key});

  @override
  State<myridesinfo> createState() => _myridesinfoState();
}

class _myridesinfoState extends State<myridesinfo> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('My rides',style: robotoBlackProfile),),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height*0.87,
          width: MediaQuery.of(context).size.width,
          color: ColorConstant.WHITE_BACKGROUND,
          child: Column(

            children: [
               SizedBox(height:height*0.03),
              SizedBox(
                height: height*0.15,
                width: width*0.9,
                child: Column(
                  children: [
                     SizedBox(
                      height: height*0.03,
                      width:width*0.9,
                      child: Row(
                        children: [
                          const Text('Category',style: robotoMediumBlack),
                          Padding(
                            padding: EdgeInsets.only(left:height*0.27),
                            child: const Text('Bike',style: robotoBlack,),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[600]),
                    SizedBox(
                      height: height*0.03,
                      width:width*0.9,
                      child: Row(
                        children: [
                          const Text('Date of Ride',style: robotoMediumBlack),
                          Padding(
                            padding: EdgeInsets.only(left: height*0.06),
                            child: const Text('21/04/2023 | 7 days ago',style: robotoBlack,),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[600]),
                    SizedBox(
                      height: height*0.025,
                      width:width*0.9,
                      child: Row(
                        children: [
                          const Text('Date of Ride',style: robotoMediumBlack),
                          Padding(
                            padding: EdgeInsets.only(left: height*0.06),
                            child: const Text('RD16883064337054047',style: robotoBlack,),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[600]),
                  ],
                ),
              ),
                    SizedBox(height: height*0.015),
              Card(
                color: ColorConstant.WHITE_COL0R,
                child:SizedBox(
                  height:height*0.15,
                  width: width*0.85,
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left:height*0.02),
                        child: SizedBox(
                          height:height*0.15,
                          width: width*0.15,
                          child: Container(
                            height: height*0.06,
                            width: width*0.06,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorConstant.Black_COLOR
                            ),
                            child: const Icon(Icons.person,color: ColorConstant.WHITE_COL0R,size: 35,),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height*0.15,
                        width: width*0.5,
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: height*0.02),
                              child: SizedBox(
                                height: height*0.06,
                               child: Center(
                                 child: RichText(
                                   text: const TextSpan(
                                     text: "Senthil Kumar R\n",
                                     style:   robotoMediumBlack,
                                     children: <TextSpan>[
                                       TextSpan(
                                         text: '       your ratings',
                                         style:robotoBlack,
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.05,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width*0.4,
                                    child: const Center(
                                      child: Text(
                                        '★★★☆☆',style: TextStyle(color: Colors.amber,fontSize: 25),
                                      ),
                                    )
                                  ),
                                  SizedBox(
                                      width: width*0.08,
                                      child: const Center(
                                        child: Text(
                                          '3/5',style: robotoBlack,
                                        ),
                                      )
                                  ),
                                ],
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
              SizedBox(
                height: height*0.08,
                width: width*0.85,
                child: Column(
                  children: [
                    SizedBox(
                      height: height*0.025,
                      width: width*0.85,
                      child: Row(
                        children: [
                          const Text('Fare',style: robotoMediumBlack),
                          Padding(
                            padding: EdgeInsets.only(left: width*0.65),
                            child: const Text('45.0',style: robotoBlack,),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey[600],),
                    SizedBox(
                      height: height*0.03,
                      width: width*0.85,
                      child: Row(
                        children: [
                          const Text('Mode of Payment',style: robotoMediumBlack),
                          Padding(
                            padding: EdgeInsets.only(left:width*0.33),
                            child: const Text('Cash',style: robotoBlack,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height*0.17,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.13,
                    width: width*0.45,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: "  273 Km",
                          style:   robotoBlackProfile,
                          children: const <TextSpan>[
                            TextSpan(
                              text:"\n\nDistance Covered",
                              style:robotoSmallGrey,

                            ),

                          ],
                        ),

                      ),
                    ),
                    ),
                    ),
                    Card(
                      color: ColorConstant.WHITE_COL0R,
                      child:SizedBox(
                        height: height*0.13,
                        width: width*0.45,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: "18:58:12\n",
                              style:   robotoBlackProfile,
                              children: const <TextSpan>[
                                TextSpan(
                                  text:"\n        Time",
                                  style:robotoSmallGrey,

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
          SizedBox(height:height*0.01),
              Card(
                color: ColorConstant.WHITE_COL0R,
                child:SizedBox(
                  height: height*0.18,
                  width: width*0.85,
                  child: Row(
                    children: [
                      Container(
                        height: height*0.12,
                        width: width*0.15,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Images.tofrom),
                          )
                        ),
                      ),
                      SizedBox(
                        height: height*0.18,
                        width: width*0.65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 5,),
                            Constant_text_field(
                              enabled: false,
                              controller: null,
                              keyboardType: TextInputType.name,
                              hintText: 'Railway Satation',
                              filled: true,
                              validator: Validate_Name,
                              height: height*0.06,
                              width: width*0.65,
                              fillColor: Colors.grey[300],
                            ),
                            Constant_text_field(
                              enabled: false,
                              controller: null,
                              keyboardType: TextInputType.name,
                              hintText: '2/07,Street name,Area,Code',
                              filled: true,
                              validator: Validate_Distance,
                              height: height*0.06,
                              width: width*0.65,
                              fillColor: Colors.grey[300],
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

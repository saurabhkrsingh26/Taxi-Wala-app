import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class SettingFavoutrites extends StatefulWidget {
  const SettingFavoutrites({super.key});

  @override
  State<SettingFavoutrites> createState() => _SettingFavoutritesState();
}

class _SettingFavoutritesState extends State<SettingFavoutrites> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Favoutritrs',style: robotoBlackProfile),),
      ),
      body: Container(
        height: height*0.9,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.WHITE_BACKGROUND,
        child: Column(
          children: [
            SizedBox(height:height*0.02,),
            Card(
              color: ColorConstant.WHITE_COL0R,
              child:SizedBox(
                height: height*0.25,
                width: width*0.9,
                child: Column(
                  children: [
                    Container(
                      height:height*0.11,
                      child: Padding(
                        padding:EdgeInsets.only(left: width*0.03),
                        child: Row(
                          children: [
                            Container(
                              height:height*0.07,
                              width: width*0.2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.Black_COLOR
                              ),
                              child: Icon(Icons.favorite,color: ColorConstant.WHITE_COL0R,size: 25,),
                            ),
                            Container(
                              height: height*0.11,
                              width: width*0.5,
                              child: Padding(
                                padding:EdgeInsets.only(top: height*.02,left:width*0.02),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Others",
                                    style:   robotoBold,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '\ndr Subbramaniyan St,\nSath Naryandas Layout',
                                        style:robotoBlack,
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
                    Divider(),
                    Container(
                      height:height*0.11,
                      child: Padding(
                        padding:EdgeInsets.only(left: width*0.03),
                        child: Row(
                          children: [
                            Container(
                              height:height*0.07,
                              width: width*0.2,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.Black_COLOR
                              ),
                              child: Icon(Icons.add_circle,color: ColorConstant.WHITE_COL0R,size: 25,),
                            ),
                            Container(
                              height: height*0.11,
                              width: width*0.5,
                              child: Padding(
                                padding:EdgeInsets.only(top: height*.04,left:width*0.02),
                                child:Text(
                                  'Add more',style: robotoBold,
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
          ],
        ),
      ),
    );
  }
}

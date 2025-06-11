import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class sopporthome extends StatefulWidget {
  const sopporthome({super.key});

  @override
  State<sopporthome> createState() => _sopporthomeState();
}

class _sopporthomeState extends State<sopporthome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Support',style: robotoBlackProfile),),
      ),
      body: Container(
        height: height*0.86,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.WHITE_BACKGROUND,
        child: Column(
          children: [
            SizedBox(height:height*0.02),
            Card(
              color: ColorConstant.WHITE_COL0R,
              child:SizedBox(
                  height: height*0.28,
                  width: width*0.9,
                  child:Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.PaymentRelated);
                        },
                        child: SizedBox(
                          height: height*0.05,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left: width*0.03),
                                child: const Text('Payment Related',style: robotoMediumBlack,),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left: width*0.35),
                                child: const Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 32,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.DriverRelated);
                        },
                        child: SizedBox(
                          height: height*0.05,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left: width*0.03),
                                child: const Text('Driver Related',style: robotoMediumBlack,),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left: width*0.4),
                                child: const Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 32,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.SupportGuide);
                        },
                        child: SizedBox(
                          height: height*0.05,
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text('Guide',style: robotoMediumBlack,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 220),
                                child: Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 32,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.SupportGuide);
                      },
                        child: SizedBox(
                          height: height*0.05,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left:width*0.03),
                                child: const Text('My pick up is delayed',style: robotoMediumBlack,),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left:width*0.25),
                                child: const Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 32,),
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

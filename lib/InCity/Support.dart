import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class SupportIncity extends StatefulWidget {
  const SupportIncity({super.key});

  @override
  State<SupportIncity> createState() => _SupportIncityState();
}

class _SupportIncityState extends State<SupportIncity> {
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
      body: Column(
        children: [
          Container(
            height:height*0.003,
            color: Colors.grey[300],
          ),
          SizedBox(height: height*0.020),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.Ridereview);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:Row(
                    children: [
                      SizedBox(
                        height:height*0.14,
                        width:width*0.6,
                        child: Column(
                          children: [
                            SizedBox(
                              height:height*0.045,
                              child: Padding(
                                padding:EdgeInsets.only(right:width*0.12),
                                child: Text('Today,3:20 PM',style: robotoRegularBlack,),
                              ),
                            ),
                            SizedBox(
                              height:height*0.025,
                              child: Padding(
                                padding:EdgeInsets.only(right:width*0.4),
                                child: const Text('Sedan',style: robotoBold,),
                              ),
                            ),
                            SizedBox(
                              height:height*0.027,
                              width: width*0.4,
                              child: Text('Street A,Jankipuraum,Lucknow',style: robotoBlack.copyWith(overflow: TextOverflow.ellipsis),),
                            ),
                            SizedBox(
                              height:height*0.03,
                              child: Padding(
                                padding:EdgeInsets.only(right:width*0.28),
                                child: const Text('Scheduled',style: robotoMediumBlack,),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(Images.girl),
                      ),
                    ],
                  ),
              ),
            ),
          ),
          SizedBox(height:height*0.020),
          SizedBox(
            height: height*0.34,
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
              const  Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

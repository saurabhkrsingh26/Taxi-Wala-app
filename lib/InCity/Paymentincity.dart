import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class PaymentIncity extends StatefulWidget {
  const PaymentIncity({super.key});

  @override
  State<PaymentIncity> createState() => _PaymentIncityState();
}

class _PaymentIncityState extends State<PaymentIncity> {
  bool change= true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Payment',style: robotoBlackProfile),),
      ),
      body: ListView(
        children: [
          Container(
            height:height*1.25,
            color: ColorConstant.WHITE_BACKGROUND,
            child: Column(
              children: [
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height:height*0.13,
                    width:width*0.8,
                    child: Column(
                      children: [
                       SizedBox(
                       height:height*0.05,
                       child: const Row(
                         children: [
                           Text('     Total fair:',style: robotoMediumBlack,),
                           Text('        ₹ 160',style: robotoBlack,),
                         ],
                       ),
                       ),
                        const Divider(),
                        SizedBox(
                          height:height*0.05,
                          child: const Row(
                            children: [
                              Text('     You saved:',style: robotoMediumBlack,),
                              Text('        ₹ 20',style: robotoBlack,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.006),
                SizedBox(
                  height: height*0.04,
                  width:width*0.89,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.05),
                    child: const Text('Cash',style: robotoMediumBlack),
                  ),
                ),
                SizedBox(height:height*0.005 ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.13,
                    width:width*0.9,
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          height:height*0.1,
                          width:width*0.23,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(width: 2,color: ColorConstant.WHITE_BACKGROUND),
                            image: const DecorationImage(
                              image: AssetImage(Images.cash)
                            )
                          ),
                        ),
                        SizedBox(
                          width:width*0.5,
                          child: const Text('   Pay cash on drop',style: robotoMediumBlack,),
                        ),
                        SizedBox(
                          width:width*0.06,
                          child: const Icon(Icons.check_circle_outline,color: Colors.green,size: 30,),
                        ),
                      ],
                    )
                  ),
                ),
                SizedBox(height:height*0.01),
                SizedBox(
                  height:height*0.04,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.75),
                    child: const Text('UPI',style: robotoMediumBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.18,
                    width:width*0.85,
                    child: Column(
                      children: [
                        SizedBox(
                          height:height*0.072,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left:width*0.04),
                                child: Container(
                                  height:height*0.062,
                                  width:width*0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(width: 1.5,color: ColorConstant.BORDER_COLOR),
                                      image: const DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(Images.gpay),
                                      )
                                  ),
                                ),
                              ),
                              const Text('     Googele pay',style: robotoMediumBlack,),
                            ],
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height:height*0.072,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left:width*0.04),
                                child: Container(
                                  height:height*0.062,
                                  width:width*0.12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent[100],
                                  ),
                                  child: const Icon(Icons.add,color: ColorConstant.Black_COLOR,size: 30,),
                                ),
                              ),
                              const Text('     Add New UPI ID',style: robotoMediumBlack,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.02),
                SizedBox(
                  height:height*0.04,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.35),
                    child: const Text('Credit & Debit cards',style: robotoMediumBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.18,
                    width:width*0.85,
                    child: Column(
                      children: [
                        SizedBox(
                          height:height*0.072,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left:width*0.04),
                                child: Container(
                                  height:height*0.062,
                                  width:width*0.13,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(width: 1.5,color: ColorConstant.BORDER_COLOR),
                                      image: const DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(Images.card),
                                      )
                                  ),
                                ),
                              ),
                              const Text('     Card',style: robotoMediumBlack,),
                            ],
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height:height*0.072,
                          child: Row(
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left:width*0.04),
                                child: Container(
                                  height:height*0.062,
                                  width:width*0.12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent[100],
                                  ),
                                  child: const Icon(Icons.add,color: ColorConstant.Black_COLOR,size: 30,),
                                ),
                              ),
                              const Text('     Add New UPI ID',style: robotoMediumBlack,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.02),
                SizedBox(
                  height:height*0.038,
                  width:width*0.87,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.1),
                    child: const Text('Other payment methods',style: robotoMediumBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height:height*0.25,
                    width:width*0.87,
                    child:Column(
                      children: [
                        SizedBox(
                            height:height*0.08,
                            child:Row(
                              children: [
                                Padding(
                                  padding:EdgeInsets.only(left:width*0.035),
                                  child: Container(
                                    height:height*0.06,
                                    width: width*0.12,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(width: 1.5,color: ColorConstant.BORDER_COLOR),
                                        image: const DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: AssetImage(Images.card),
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:height*0.08,
                                  child: const Center(child: Text('    Wallets',style: robotoMediumBlack,)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 110),
                                  child: SizedBox(
                                    height: 66.6,
                                    child: Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 35,),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                            height:height*0.08,
                            child:Row(
                              children: [
                                Padding(
                                  padding:EdgeInsets.only(left:width*0.035),
                                  child: Container(
                                    height:height*0.06,
                                    width: width*0.12,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(width: 1.5,color: ColorConstant.BORDER_COLOR),
                                        image: const DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: AssetImage('assets/image/card.png'),
                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 66.6,
                                  child: Center(child: Text('    Sodexo',style: robotoMediumBlack,)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 110),
                                  child: SizedBox(
                                    height: 66.6,
                                    child: Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 35,),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                            height:height*0.08,
                            child:Row(
                              children: [
                                Padding(
                                  padding:EdgeInsets.only(left:width*0.035),
                                  child: Container(
                                    height:height*0.06,
                                    width: width*0.12,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(width: 1.5,color: ColorConstant.BORDER_COLOR),
                                        image: const DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: AssetImage(Images.card),
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:height*0.06,
                                  child: const Center(child: Text('    Netbanking',style: robotoMediumBlack,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 75),
                                  child: SizedBox(
                                    height:height*0.06,
                                    child: const Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 35,),
                                  ),
                                ),
                              ],
                            )
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
      floatingActionButton: change==true?FloatingActionButton.extended(
        backgroundColor: Colors.black,

        onPressed: () {
          Navigator.pushNamed(context, RoutesName.RideConfirmation);
          setState(() {
            change=false;
          });
        },
        label: const Text('Pay With Cash',style: robotoMediumExtraWhite,),

      ):Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

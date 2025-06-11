import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
            height: height*0.95,
            color: ColorConstant.WHITE_BACKGROUND,
            child: Column(
              children: [
                SizedBox(height: height*0.02),
                SizedBox(
                  height: height*0.04,
                  child: Padding(
                    padding:  EdgeInsets.only(right:width*0.75),
                    child: const Text('UPI',style: robotolargeBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.19,
                    width: width*0.85,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height*0.08,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:  width*0.05),
                                child: Container(
                                  height: height*0.06,
                                  width: width*0.12,
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
                      height: height*0.08,
                      child: Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:  width*0.05),
                            child: Container(
                              height: height*0.06,
                              width: width*0.12,
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
                SizedBox(height: height*0.04,),
                SizedBox(
                  height: height*0.04,
                  child: Padding(
                    padding: EdgeInsets.only(right: width*0.3),
                    child: const Text('Credit & Debit cards',style: robotolargeBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.19,
                    width: width*0.85,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height*0.08,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width*0.05),
                                child: Container(
                                  height: height*0.06,
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
                              const Text('     Card',style: robotoMediumBlack,),
                            ],
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: height*0.08,
                          child: Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: width*0.05),
                                child: Container(
                                  height: height*0.06,
                                  width: width*0.12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent[100],
                                  ),
                                  child: const Icon(Icons.add,color: ColorConstant.Black_COLOR,size: 30,),
                                ),
                              ),
                              const Text('     Add new card',style: robotoMediumBlack,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.03),
                SizedBox(
                    height:height*0.045,
                  child: Padding(
                    padding: EdgeInsets.only(right: width*0.2),
                    child: const Text('Other payment methods',style: robotolargeBlack),
                  ),
                ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.23,
                    width: width*0.85,
                    child:Column(
                      children: [
                        SizedBox(
                          height: height*0.08,
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width*0.035),
                                child: Container(
                                  height: height*0.06,
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
                                height:  height*0.06,
                                child: const Center(child: Text('    Wallets',style: robotoMediumBlack,)),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left:width*0.3),
                                child: SizedBox(
                                  height:  height*0.06,
                                  child: const Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 35,),
                                ),
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                            height:  height*0.06,
                            child:Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.03 ),
                                  child: Container(
                                    height: height*0.06,
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
                                  height: height*0.06,
                                  child: const Center(child: Text('    Sodexo',style: robotoMediumBlack,)),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(left: width*0.3),
                                  child: SizedBox(
                                    height: height*0.06,
                                    child: const Icon(Icons.navigate_next,color: ColorConstant.Black_COLOR,size: 35,),
                                  ),
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                            height: height*0.08,
                            child:Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width*0.035),
                                  child: Container(
                                    height: height*0.06,
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
                                  height: height*0.06,
                                  child: const Center(child: Text('    Netbanking',style: robotoMediumBlack,)),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(left:width*0.2),
                                  child: SizedBox(
                                    height: height*0.06,
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
            );
  }
}

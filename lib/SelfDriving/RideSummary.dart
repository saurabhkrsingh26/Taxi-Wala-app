import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class RideSummary extends StatefulWidget {
  const RideSummary({super.key});

  @override
  State<RideSummary> createState() => _RideSummaryState();
}

class _RideSummaryState extends State<RideSummary> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Ride summary',style: robotoBlackProfile),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: height*1.2,
            width: MediaQuery.of(context).size.width,
            color: ColorConstant.WHITE_BACKGROUND,
            child: Column(
              children: [
                SizedBox(height:height*0.02),
                  Container(
                    height:height*0.17,
                    width: width*0.9,
                    child: Column(
                      children: [
                        Container(
                          height:height*0.03,
                          width: width*0.9,
                          child: Row(
                            children: [
                              Container(
                                child: Text('Category',style: robotoMediumBlack),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left:width*0.44),
                                child: Container(
                                  child: Text('Self driving',style: robotoBlack,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey[600]),
                        Container(
                          height:height*0.03,
                          width: width*0.9,
                          child: Row(
                            children: [
                              Container(
                                child: Text('Date of Ride',style: robotoMediumBlack),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left: width*0.38),
                                child: Container(
                                  child: Text('21/4/2023',style: robotoBlack,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey[600]),
                        Container(
                          height:height*0.03,
                          width: width*0.9,
                          child: Row(
                            children: [
                              Container(
                                child: Text('Date of Ride',style: robotoMediumBlack),
                              ),
                              Padding(
                                padding:EdgeInsets.only(left: width*0.14),
                                child: Container(
                                  child: Text('RD16883064337054047',style: robotoBlack,),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.grey[600]),
                      ],
                    ),
                  ),
                Card(
                  color: ColorConstant.WHITE_COL0R,
                  child:SizedBox(
                    height: height*0.15,
                    width:width*0.8,
                    child: Row(
                      children: [
                        Padding(
                          padding:EdgeInsets.only(left:width*0.04),
                          child: Container(
                            height: height*0.15,
                            width: width*0.15,
                            child: Container(
                              height: height*0.07,
                              width: width*0.15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.Black_COLOR
                              ),
                              child: Icon(Icons.person,color: ColorConstant.WHITE_COL0R,size: 35,),
                            ),
                          ),
                        ),
                        Container(
                          height: height*0.15,
                          width:width*0.6,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  height: 40,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
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
                              Container(
                                height:height*0.05,
                                child: Row(
                                  children: [
                                    Container(
                                        width:width*0.43,
                                        child: Center(
                                          child: Text(
                                            '     ★★★☆☆',style: TextStyle(color: Colors.amber,fontSize: 25),
                                          ),
                                        )
                                    ),
                                    Container(
                                        width:width*0.12,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Text(
                                              '3/5',style: robotoBlack,
                                            ),
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
                SizedBox(height:height*0.01,),
            Card(
              margin:EdgeInsets.symmetric(vertical:height*0.01, horizontal:width*0.04),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: height*0.15,
                      width: width*0.64,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(Images.fortuner),
                          )
                      ),
                    ),
                    SizedBox(height:height*0.01,),
                    const Text('Toyota Fortuner',style: robotoMediumBlack,),
                    SizedBox(height:height*0.01,),
                    Row(
                      children: [
                        SizedBox(width: width*0.03),
                        Container(
                          height:height*0.03,
                          width:width*0.07,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.engine),
                              )
                          ),
                        ),
                        SizedBox(
                            height:height*0.03,
                            width: width*0.15,
                            child:const Center(child: Text('2523cc',style: robotoBlack,))
                        ),
                        SizedBox(width:width*0.03),
                        Container(
                          height:height*0.03,
                          width:width*0.07,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.fule),
                              )
                          ),
                        ),
                        SizedBox(
                            height:height*0.03,
                            width: width*0.13,
                            child:const Center(child: Text('Petrol',style: robotoBlack,))
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          height:height*0.03,
                          width:width*0.07,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.member),
                              )
                          ),
                        ),
                        SizedBox(
                            height:height*0.03,
                            width: width*0.04,
                            child:const Center(child: Text('5',style: robotoBlack,))
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          height:height*0.03,
                          width:width*0.07,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.beg),
                              )
                          ),
                        ),
                         SizedBox(
                            height:height*0.03,
                            width: width*0.04,
                            child:Center(child: Text('4',style: robotoBlack,))
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
                SizedBox(height:height*0.01),
                Container(
                  height:height*0.11,
                  width:width*0.9,
                  child: Column(
                    children: [
                      Container(
                        height:height*0.03,
                        width:width*0.9,
                        child: Row(
                          children: [
                            Container(
                              child: Text('Fare',style: robotoMediumBlack),
                            ),
                            Padding(
                              padding:EdgeInsets.only(left:width*0.55),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Icon(Icons.currency_rupee_sharp,size: 18,),
                                    ),
                                    Container(
                                      child: Text('24,485.00',style: robotoBlack,),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey[600]),
                      Container(
                        height:height*0.03,
                        width:width*0.9,
                        child: Row(
                          children: [
                            Container(
                              child: Text('Mode of Payment',style: robotoMediumBlack),
                            ),
                            Padding(
                              padding:EdgeInsets.only(left:width*0.38),
                              child: Container(
                                child: Text('Card',style: robotoBlack,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height:height*0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: ColorConstant.WHITE_COL0R,
                        child:SizedBox(
                          height: height*0.14,
                          width: width*0.44,
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
                          height: height*0.14,
                          width: width*0.44,
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
  String? Validate_Distance(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

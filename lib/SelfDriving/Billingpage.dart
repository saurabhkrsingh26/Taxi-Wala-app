import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class Billingpage extends StatefulWidget {
  const Billingpage({super.key});

  @override
  State<Billingpage> createState() => _BillingpageState();
}

class _BillingpageState extends State<Billingpage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Self driving',style: robotoBlackProfile),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: height*1.53,
            width: MediaQuery.of(context).size.width,
            color: ColorConstant.WHITE_BACKGROUND,
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          child: Text('Toyota Fortuner',style: robotoMediumBlack,),
                        ),
                        SizedBox(height:height*0.01,),
                        Container(
                          height: height*0.15,
                          width:width*0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(Images.fortuner),
                              )
                          ),
                        ),
                        SizedBox(height:height*0.01),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: width*0.07),
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
                              const SizedBox(
                                  height: 30,
                                  width: 10,
                                  child:Center(child: Text('4',style: robotoBlack,))
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height:height*0.01),
                        Container(
                          child: Padding(
                            padding:EdgeInsets.only(right:width*0.6),
                            child: Text('Features',style: robotoMediumBlack,),
                          ),
                        ),
                        Container(
                            height:height*0.04,
                            child: Row(
                              children: [
                                Container(
                                  child: Text('•',style: TextStyle(fontSize: 30),),
                                ),
                                Container(
                                  child: Padding(
                                    padding:EdgeInsets.only(top:height*0.01),
                                    child: Text('   Gearbox:Manual',),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height:height*0.04,
                            child: Row(
                              children: [
                                Container(
                                  child: Text('•',style: TextStyle(fontSize: 30),),
                                ),
                                Container(
                                  child: Padding(
                                    padding:EdgeInsets.only(top:height*0.01),
                                    child: Text('   Air-Condition',),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height:height*0.04,
                            child: Row(
                              children: [
                                Container(
                                  child: Text('•',style: TextStyle(fontSize: 30),),
                                ),
                                Container(
                                  child: Padding(
                                    padding:EdgeInsets.only(top:height*0.01),
                                    child: Text('   ABS',),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height:height*0.04,
                            child: Row(
                              children: [
                                Container(
                                  child: Text('•',style: TextStyle(fontSize: 30),),
                                ),
                                Container(
                                  child: Padding(
                                    padding:EdgeInsets.only(top:height*0.01),
                                    child: Text('   Airbages number: 2',),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            height:height*0.04,
                            child: Row(
                              children: [
                                Container(
                                  child: Text('•',style: TextStyle(fontSize: 30),),
                                ),
                                Container(
                                  child: Padding(
                                    padding:EdgeInsets.only(top:height*0.01),
                                    child: Text('   Fule:Petrol',),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.01),
                Container(
                  height: height*0.05,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.75),
                    child: Text("Extras",style: robotoMediumBlack,),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Container(
                          child: Text('Collision Damage Waiver',style: robotoBold,),
                        ),
                        Container(
                          child: Padding(
                            padding:EdgeInsets.only(left:width*0.25),
                            child: Text('+2000',),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.01),
                Container(
                  height: height*0.04,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.65),
                    child: Text("Discount",style: robotoMediumBlack,),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Container(
                          child: Text('Enter coupon code',style: robotoBold,),
                        ),
                        SizedBox(width:width*0.07),
                        Constant_text_field(
                          controller: null,
                          keyboardType: TextInputType.name,
                          hintText: '',
                          filled: true,
                          validator: Validate_Cupoon,
                          height:height*0.05,
                          width:width*0.38,
                          fillColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height:height*0.01,),
                Container(
                  height: height*0.04,
                  child: Padding(
                    padding:EdgeInsets.only(right:width*0.55),
                    child: Text("Price analysis",style: robotoMediumBlack,),
                  ),
                ),
                Container(
                  height:height*0.06,
                  width:width*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orangeAccent[100],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height:height*0.04,
                        width:width*0.13,
                        child: Icon(Icons.warning,color: Colors.red,),
                      ),
                      Container(
                        child: Text('Note 30% of the of the total is required\nfor booking the vehicle',style: TextStyle(color: Colors.black54),),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height:height*0.04,
                          child: Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Container(
                                child: Text('Rental fee',style: robotoBold,),
                              ),
                              SizedBox(width:width*0.35),
                              Container(
                                child: Icon(Icons.currency_rupee,size: 20,),
                              ),
                              Container(
                                child: Text('15400.00'),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height:height*0.04,
                          child: Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Container(
                                child: Text('Pick up',style: robotoBold,),
                              ),
                              SizedBox(width:width*0.4),
                              Container(
                                child: Icon(Icons.currency_rupee,size: 20,),
                              ),
                              Container(
                                child: Text('750.00'),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height:height*0.04,
                          child: Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Container(
                                child: Text('Drop off',style: robotoBold,),
                              ),
                              SizedBox(width:width*0.4),
                              Container(
                                child: Icon(Icons.currency_rupee,size: 20,),
                              ),
                              Container(
                                child: Text('750.00'),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height:height*0.04,
                          child: Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Container(
                                child: Text('Cupon',style: robotoBold,),
                              ),
                              SizedBox(width:width*0.43),
                              Container(
                                child: Icon(Icons.currency_rupee,size: 20,),
                              ),
                              Container(
                                child: Text('0.00'),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height:height*0.04,
                          child: Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Container(
                                child: Text('Tax',style: robotoBold,),
                              ),
                              SizedBox(width:width*0.47),
                              Container(
                                child: Icon(Icons.currency_rupee,size: 20,),
                              ),
                              Container(
                                child: Text('3735.00'),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          height:height*0.04,
                          child: Row(
                            children: [
                              SizedBox(width:width*0.04),
                              Container(
                                child: Text('Subtotal',style: robotoBold,),
                              ),
                              SizedBox(width:width*0.37),
                              Container(
                                child: Icon(Icons.currency_rupee,size: 20,),
                              ),
                              Container(
                                child: Text('24,485.00'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               Spacer(),
                Container(
                  height:height*0.13,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.only(topRight: Radius.circular(13),topLeft: Radius.circular(13)),
                    color: ColorConstant.WHITE_COL0R
                  ),
                  child: Row(
                    children: [
                      Container(
                        width:width*0.43,
                        child: Column(
                          children: [
                            SizedBox(height:height*0.019),
                            Container(
                              height:height*0.04,
                              child: Center(child: Text('    Advanced Payment',style: robotoBold,)),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(width:width*0.05,),
                                  Container(
                                    child: Icon(Icons.currency_rupee,size: 20,),
                                  ),
                                  Container(
                                    child: Text('15,000.00',),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width:width*0.08,),
                      ColorButton(onTap: () {
                        Navigator.pushNamed(context, RoutesName.DocumentPage);
                      }, text: 'Proceed', btnColor: ColorConstant.Black_COLOR, textColor: ColorConstant.WHITE_COL0R,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  String? Validate_Cupoon(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class selfdrivingall extends StatefulWidget {
  const selfdrivingall({super.key});

  @override
  State<selfdrivingall> createState() => _selfdrivingallState();
}

class _selfdrivingallState extends State<selfdrivingall> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
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
                      const SizedBox(
                          height: 30,
                          width: 10,
                          child:Center(child: Text('4',style: robotoBlack,))
                      ),
                    ],
                  ),
                  SizedBox(height:height*0.01),
                  ColorButton(onTap: () {
                    Navigator.pushNamed(context, RoutesName.Billingpage);
                  }, text: 'Book now', btnColor: ColorConstant.Black_COLOR, textColor: ColorConstant.WHITE_COL0R,),
                ],
              ),
            ),
          );
        }
    );
  }
}

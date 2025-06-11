import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/PinFileld.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class OTPpages extends StatefulWidget {
  const OTPpages({super.key});

  @override
  State<OTPpages> createState() => _OTPpagesState();
}

class _OTPpagesState extends State<OTPpages> {
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
      body: Container(
        color: ColorConstant.WHITE_BACKGROUND,
        child:  Column(
          children: [
            SizedBox(height:height*0.03),
            Custom_pin_field(),
            SizedBox(height:height*0.02),
            Container(
              height:height*0.08,
              width: width*0.9,
             decoration: BoxDecoration(
               color: Colors.orangeAccent[100],
               borderRadius: const BorderRadius.all(Radius.circular(10)),
             ),
              child: Row(
                children: [
                  SizedBox(
                    height:height*0.08,
                    width: width*0.15,
                    child: const Icon(Icons.warning,color: Colors.orange,),
                  ),
                  const Text('Note: You will be redirected to the\nconfirmantion page once the host has\nsubmitted the code'),
                ],
              ),
            ),
            SizedBox(height:height*0.02),
            Padding(
              padding:EdgeInsets.only(right:width*0.6),
              child: const Text('Instructions:',style: robotoMediumBlack,),
            ),
            SizedBox(height:height*0.01),
            SizedBox(
              height:height*0.16,
              child: Row(
                children: [
                  SizedBox(width:width*0.05),
                  SizedBox(
                    height:height*0.16,
                    width: width*0.02,
                    child: const Text('•',style: TextStyle(fontSize: 30),),
                  ),
                  SizedBox(width: width*0.04,),
                  SizedBox(
                    height:height*0.16,
                    child: const Text('You agree to return the car to us in the same condition\nyou received it, ordinary wear and tear excepted, on the\ndate, at the time and to thelocation specified in the\nRental Contract The car must be returned to the agreed\nreturn location as specified on the Rental Contract If\nreturn is indicated to a location other than the location\nwhere your rental commences, you my have to pay\na one way service fee',style: TextStyle(fontSize: 12),),
                  ),
                ],
              ),
            ),
            SizedBox(height:height*0.01),
            SizedBox(
              height:height*0.16,
              child: Row(
                children: [
                  SizedBox(width:width*0.05),
                  SizedBox(
                    height:height*0.16,
                    width: width*0.02,
                    child: const Text('•',style: TextStyle(fontSize: 30),),
                  ),
                  SizedBox(width:width*0.05),
                  SizedBox(
                    height:height*0.16,
                    child: const Text('You agree to return the car to us in the same condition\nyou received it, ordinary wear and tear excepted, on the\nndate, at the time and to the location specified in the\nRental Contract. The car must be returned to the agreed\nreturn location as specified on the Rental Contract. If\nreturn is indicated to a location other than the location\nwhere your rental commences, you may have to pay a\none way service fee',style: TextStyle(fontSize: 12),),
                  ),
                ],
              ),
            ),
            SizedBox(height:height*0.09),
            CustomButton(onTap: () {
              Navigator.pushNamed(context, RoutesName.RideSummary);
            }, text: 'Verify to end',),
          ],
        )
      ),
    );
  }
}

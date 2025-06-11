import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class SettingLanguage extends StatefulWidget {
  const SettingLanguage({super.key});

  @override
  State<SettingLanguage> createState() => _SettingLanguageState();
}

class _SettingLanguageState extends State<SettingLanguage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Support',style: robotoBlackProfile),),
      ),
      body: Container(
        height: height*0.9,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.WHITE_BACKGROUND,
        child: Column(
          children: [
            SizedBox(height:height*0.03),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text('English',style: robotoMediumBlack,),
              ),
            ),
            SizedBox(height:height*0.03),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 220),
                child: Text('Hindi',style: robotoMediumBlack,),
              ),
            ),
            SizedBox(height:height*0.03),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 190),
                child: Text('Kannada',style: robotoMediumBlack,),
              ),
            ),
            SizedBox(height:height*0.03),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 220),
                child: Text('Tamil',style: robotoMediumBlack,),
              ),
            ),
            SizedBox(height:height*0.03),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text('Marathi',style: robotoMediumBlack,),
              ),
            ),
            SizedBox(height:height*0.03),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 210),
                child: Text('Telugu',style: robotoMediumBlack,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

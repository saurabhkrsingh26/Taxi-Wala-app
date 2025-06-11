import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxiwala/Constant/Constant_textfield/ConstantImagepicker.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
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
     body: SingleChildScrollView(
       reverse: true,
       child: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         color: ColorConstant.WHITE_BACKGROUND,
         child: Column(
           children: [
             SizedBox(height:height*0.02),
             Padding(
               padding:EdgeInsets.only(right:width*0.6),
               child: const Text('Driver name',style: robotoMediumBlack,),
             ),
             SizedBox(height:height*0.02),
             Constant_text_field(
               controller: null,
               keyboardType: TextInputType.name,
               hintText: '',
               filled: true,
               validator: Validate_Name,
               height:height*0.065,
               width: width*0.9,
               fillColor: Colors.grey[300],
             ),
             SizedBox(height:height*0.02),
             Padding(
               padding:EdgeInsets.only(right:width*0.53),
               child: const Text('Driver\'s license',style: robotoMediumBlack,),
             ),
             SizedBox(height:height*0.02),
             CustomButton(onTap: () {
                 _settingModalBottomSheet(context);
             }, text: 'Upload file',),
             SizedBox(height:height*0.02),
             Padding(
               padding:EdgeInsets.only(right:width*0.35),
               child: const Text('Driver\'s license number',style: robotoMediumBlack,),
             ),
             SizedBox(height:height*0.02),
             Constant_text_field(
               controller: null,
               keyboardType: TextInputType.number,
               hintText: '',
               filled: false,
               validator: Validate_Number,
               height:height*0.065,
               width: width*0.9,
               fillColor: Colors.grey[300],
             ),
             SizedBox(height:height*0.02),
             ColorButton(onTap: () {
               Navigator.pushNamed(context, RoutesName.driverLocation);
             }, text: 'Book now', btnColor: ColorConstant.Black_COLOR, textColor: ColorConstant.WHITE_BACKGROUND,),
           ],
         ),
       ),
     ),
    );
  }
  String myData = '0';
  void _updateImage(ImageSource imageSource) async {
    String? imageData = await ChooseImage.chooseImageAndConvertToString(imageSource);
    if (imageData != null) {
      setState(() {
        myData = imageData;
      });
    }
  }
  void _settingModalBottomSheet(context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: heights / 7,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  widths / 12, 0, widths / 12, heights / 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _updateImage(ImageSource.camera);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                          border: Border.all(color: ColorConstant.Black_COLOR, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                            "Camera",
                            style: TextStyle(color: ColorConstant.Black_COLOR),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _updateImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                          color: ColorConstant.Black_COLOR,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                            "Gallery",
                            style: TextStyle(color:ColorConstant.WHITE_COL0R),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String? Validate_Name(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
  String? Validate_Number(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

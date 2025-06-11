import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/HomeDirectory/slidingSwitch.dart';

class ShowDataWidget extends StatefulWidget {
  @override
  State<ShowDataWidget> createState() => _ShowDataWidgetState();
}

class _ShowDataWidgetState extends State<ShowDataWidget> {
  bool _isSecondPage = false;

  void _toggleSwitch(bool value) {
    setState(() {
      _isSecondPage = value;
    });
  }

  Widget showdata(int index, context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (index % 4 == 0) {
      return Column(
        children: [
         Center(
           child: SlidingSwitch(
             value:  _isSecondPage,
             width: width,
             onChanged:  _toggleSwitch,
             height: height*0.089,
             animationDuration: const Duration(milliseconds: 400),
             onTap: () {

             },
             onDoubleTap: () {},
             onSwipe: () {

             },
             textOff: "Incity",
             textOn: "Self Driving",
             colorOn: ColorConstant.Black_COLOR,
             colorOff: ColorConstant.Black_COLOR,
             background:ColorConstant.CARD_SHADOW_COLOR,
             buttonColor: ColorConstant.RED_COLOR,
             inactiveColor: Colors.black45,
           ),
         ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Implement the build method and return the result of the showdata method
    return showdata(0, context);
  }
}
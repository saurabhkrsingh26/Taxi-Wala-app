import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class notificationDrwaer extends StatefulWidget {
  const notificationDrwaer({super.key});

  @override
  State<notificationDrwaer> createState() => _notificationDrwaerState();
}

class _notificationDrwaerState extends State<notificationDrwaer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('Notification',style: robotoBlackProfile),),
      ),
      body: Container(
        height: height*0.86,
        width: MediaQuery.of(context).size.width,
        color: ColorConstant.WHITE_BACKGROUND,
         child:
         ListView.builder(
        itemCount: 1,
    itemBuilder: (context, index) {
    return const Card(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
        child: Padding(
        padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Text('Cash back offer',style: robotoMediumBlack,),
              Padding(
                padding: EdgeInsets.only(left: 80),
                child: Text('14 min ago',style: robotoBold,),
              ),
            ],
          ),
      )
    );
    }
    ),
    )
    );
  }
}

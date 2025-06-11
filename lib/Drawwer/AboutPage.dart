import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';

class Aboutpage extends StatefulWidget {
  const Aboutpage({super.key});

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('About',style: robotoBlackProfile),),
      ),
      body:  Container(
    height: height*0.85,
    width: MediaQuery.of(context).size.width,
    color: ColorConstant.WHITE_BACKGROUND,
    child: Column(
      children: [
        SizedBox(height:height*0.025),
        Card(
      color: ColorConstant.WHITE_COL0R,
      child:SizedBox(
        height: height*0.21,
        width: width*0.95,
         child: Column(
           children: [
             InkWell(
               onTap: (){
                 Navigator.pushNamed(context, RoutesName.AboutPrivecy);
               },
               child: SizedBox(
                 height: height*0.05,
                 child: Padding(
                   padding: EdgeInsets.only(right:width*0.45),
                   child: const Center(child: Text('Privecy Policies',style: robotoMediumBlack,)),
                 ),
               ),
             ),
             const Divider(),
             InkWell(
               onTap: (){
                 Navigator.pushNamed(context, RoutesName.AboutTerm);
               },
               child: SizedBox(
                 height: height*0.05,
                 child: Padding(
                   padding:EdgeInsets.only(right:width*0.35),
                   child: const Center(child: Text('Term and Condiitions',style: robotoMediumBlack,)),
                 ),
               ),
             ),
             const Divider(),
             InkWell(
               onTap: (){
                 Navigator.pushNamed(context, RoutesName.AboutSoftware);
               },
               child: SizedBox(
                 height:height*0.05,
                 child: Padding(
                   padding:EdgeInsets.only(right: width*0.4),
                   child: const Center(child: Text('Software Licences',style: robotoMediumBlack,)),
                 ),
               ),
             ),
           ],
         ),
        ),
        ),
      ],
    ),
    ),
    );
  }
}

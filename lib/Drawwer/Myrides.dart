import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
void main() {
  runApp(const Myrides());
}


class Myrides extends StatefulWidget {
  const Myrides({super.key});

  @override
  State<Myrides> createState() => _MyridesState();
}

class _MyridesState extends State<Myrides> {
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
    height: height*1,
    width: MediaQuery.of(context).size.width,
    color: ColorConstant.WHITE_BACKGROUND,
    child:ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: height*0.01, horizontal:width*0.05),
            child: Padding(
                padding: EdgeInsets.all(width*0.01),
              child: Column(
                children: [
                  SizedBox(
                    height: height*0.04,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Text('  Thrusday,21 st',style: robotoBold,),
                        Padding(
                          padding: const EdgeInsets.only(left: 130),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RoutesName.myridesinfo);
                            },
                            child: Container(
                              height: height*0.03,
                              width: width*0.2,
                              decoration: const BoxDecoration(
                                color: ColorConstant.Black_COLOR,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: const Center(child: Text('More info',style: robotoMediumWhite,)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height*0.01,),
                 SizedBox(
                   height: height*0.12,
                   child: Row(
                     children: [
                       Container(
                         height:  height*0.1,
                         width: width*0.1,
                         decoration: const BoxDecoration(
                           image: DecorationImage(
                             fit: BoxFit.cover,
                             image: AssetImage(Images.tofrom),
                           )
                         ),
                       ),
                       SizedBox(
                         height: height*0.14,
                         width: width*0.7,
                         child: Column(
                           children: [
                             Constant_text_field(
                               enabled: false,
                               controller: null,
                               keyboardType: TextInputType.name,
                               hintText: 'Railway Station',
                               filled: true,
                               width: width*0.8,
                               height: height*0.06,
                               fillColor: Colors.grey[300],
                             ),
                             Constant_text_field(
                               enabled: false,
                               controller: null,
                               keyboardType: TextInputType.name,
                               hintText: '2/07,Street name,Area,Code',
                               filled: true,
                               width:  width*0.8,
                               height: height*0.06,
                               fillColor: Colors.grey[300],
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                  SizedBox(
                    height: height*0.04,
                    width: MediaQuery.of(context).size.width,
                   child: const Row(
                     children: [
                       SizedBox(
                         height: 40,
                         width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.horizontal_distribute_outlined),
                            Text('  7.3 Km'),
                          ],
                        ),
                       ),
                       SizedBox(
                         height: 40,
                         width: 100,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.currency_rupee),
                             Text('160'),
                           ],
                         ),
                       ),
                       SizedBox(
                         height: 40,
                         width: 100,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.credit_card),
                             Text('  card'),
                           ],
                         ),
                       ),
                     ],
                   ),
                  ),
                ],
              ),
            ),
          );
        }
    ),
    ),
    );
  }
}

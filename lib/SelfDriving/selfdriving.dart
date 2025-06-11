import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/SelfDriving/Autommatic.dart';
import 'package:taxiwala/SelfDriving/Diesal.dart';
import 'package:taxiwala/SelfDriving/SelfdrivingPremium.dart';
import 'package:taxiwala/SelfDriving/offroad.dart';
import 'package:taxiwala/SelfDriving/selfdrivingall.dart';

class selfdriving extends StatefulWidget {
  const selfdriving({super.key});

  @override
  State<selfdriving> createState() => _selfdrivingState();
}

class _selfdrivingState extends State<selfdriving> {
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
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: height*0.065,
              width: width*0.9,
              child:Constant_text_field(
                controller: null,
                keyboardType: TextInputType.name,
                hintText: 'Search for car',
                filled: true,
                validator: Validate_Distance,
                width: width*0.85,
                height: height*0.065,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.search),
              ),
        ),
            Container(
              constraints: BoxConstraints.expand(height:height*0.065,),
              child: TabBar(
                  tabs: [
                    Tab(
                      child: Container(
                          height:height*0.065,
                          width:width*0.32,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.box),
                            ),
                          )
                      ),
                    ),
                Tab(
                  child: Container(
                      height:height*0.065,
                      width:width*0.32,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.pre),
                        ),
                      )
                  ),
                ),
                Tab(
                  child: Container(
                      height:height*0.065,
                      width:width*0.32,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.road),
                        ),
                      )
                  ),
                ),
                Tab(
                  child: Container(
                      height:height*0.065,
                      width:width*0.32,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.Desial),
                        ),
                      )
                  ),
                ),
                Tab(
                  child: Container(
                      height:height*0.065,
                      width:width*0.32,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.gear),
                        ),
                      )
                  ),
                ),
              ]),
            ),
            const Expanded(
              child: TabBarView(children: [
                selfdrivingall(),
                SelfdrivingPremium(),
                offroad(),
                Diesal(),
                Automatic(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
  String? Validate_Distance(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/LoginDirectory/Login.dart';

class OnbordingScreen3 extends StatefulWidget {
  const OnbordingScreen3({super.key});

  @override
  State<OnbordingScreen3> createState() => _OnbordingScreen3State();
}

class _OnbordingScreen3State extends State<OnbordingScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 80),
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Images.Onbording_Screen3)
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 45,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(child: Text('Skip',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700))),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child:  Container(
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child:Center(child: Text('Let\'s go',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)))
                        ),
                      ),
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
}

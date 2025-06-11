import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/OnBordingDirectory/OnbordingScreen3.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
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
                        image: AssetImage(Images.Onbording_Screen2)
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnbordingScreen3()));
                        },
                        child:  Container(
                            height: 45,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child:Center(child: Text('Next',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)))
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

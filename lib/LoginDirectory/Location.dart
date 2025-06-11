import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Route/RouteNames.dart';


class TurnOnLoccation extends StatefulWidget {
  const TurnOnLoccation({super.key});

  @override
  State<TurnOnLoccation> createState() => _TurnOnLoccationState();
}

class _TurnOnLoccationState extends State<TurnOnLoccation> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h*0.2),
                Container(
                  height: h*0.4,
                  width: w*0.9,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Images.Location),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: CustomButton(onTap: () {
                    Navigator.pushNamed(context, RoutesName.Homepage);
                  }, text: 'Turn on your location',
                    textColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
        ]
          ),
        ),
      ),
    );
  }
}

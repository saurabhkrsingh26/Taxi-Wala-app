import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/dimensions.dart';
import 'package:taxiwala/OnBordingDirectory/OnBordingWegit.dart';
import 'package:taxiwala/Route/RouteNames.dart';
class OnBoardingModel {
  final String imagePath;

  OnBoardingModel({
    required this.imagePath,
  });
}
// Import your ColorResources

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  // Replace onBoardingList with a list of three elements
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(

      imagePath: Images.Onbording_Screen1, // Replace with your actual image path

    ),
    OnBoardingModel(

      imagePath: Images.Onbording_Screen2, // Replace with your actual image path

    ),
    OnBoardingModel(

      imagePath: Images.Onbording_Screen3, // Replace with your actual image path

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return OnBoardingWidget(onBoardingModel: onBoardingList[index]);
                },
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _pageIndicators(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Stack(children: [
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                      value: (selectedIndex + 1) / onBoardingList.length,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      if (selectedIndex == onBoardingList.length - 1) {
                   Navigator.pushNamed(context, RoutesName.LoginPage);
                      } else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                      child: Icon(
                        selectedIndex == onBoardingList.length - 1 ? Icons.check : Icons.navigate_next,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),

              ]),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _pageIndicators(BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == selectedIndex ? 20 : 10,
          height: 10,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == selectedIndex ? Theme.of(context).primaryColor : ColorConstant.CARD_SHADOW_COLOR,
            borderRadius: i == selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}

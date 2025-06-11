// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/Constant_textfield/PinFileld.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/dimensions.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/res/provider/verificationProvider.dart';

class Verification_page extends StatefulWidget {
  const Verification_page({super.key});

  @override
  State<Verification_page> createState() => _Verification_pageState();
}
class _Verification_pageState extends State<Verification_page> {
  VerificationProvider verificationProvider=VerificationProvider();
  List<TextEditingController> otpCon = List.generate(4, (index) => TextEditingController(),
  );
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      verificationProvider.Otp_send(context,args["phone"].toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final verificationProvider = Provider.of<VerificationProvider>(context);
    Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String phone = args["phone"];
    String id = args["id"];
    String status =args["status"];
    final height = MediaQuery.of(context).size.height;
    return
      SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.15),
              Text("Verification Code",
              style: robotoExtraLarge,
              ),
              SizedBox(height: height*0.01,),
              RichText(
                text: const TextSpan(
                  text: "Enter the OTP sent via SMS to:  ",
                  style:   robotoSmallGrey,
                  children: <TextSpan>[
                    TextSpan(
                      text: '+91 1234567890',
                      style:robotoBlack,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height*0.03,),
              Custom_pin_field(
                controllers: otpCon,
              ),
              Center(
                child: TextButton(onPressed: (){}, child: Text('Resend code',
                  style: robotoExtrasmall,
                ) ),
              ),
              const Spacer(),
              Center(
                child: CustomButton(onTap: () {
                  verificationProvider.verifyOtp(context, phone.toString(), otpCon.map((e) => e.text).join().toString(), id.toString(),status.toString());
                  // Navigator.pushNamed(context, RoutesName.SignupPage);
                }, text: 'Verify',
                  textColor: Colors.white,
                ),
              ),
              SizedBox(height: height*0.04,),
            ],
          ),
        ),
      ),
    );
  }
}

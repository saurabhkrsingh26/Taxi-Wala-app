// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/dimensions.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/res/provider/aurthProvider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  final TextEditingController mobile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider= Provider.of<AuthProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.1),
                Text('Welcome back',
                style: robotoExtraLarge,
                ),
                SizedBox(height: height*0.02,),

                const Text('Login to your account',
                  style: robotoBlack,
                ),
                SizedBox(height: height*0.04,),

                Constant_text_field(
                              controller: mobile,
                              hintText: 'Mobile Number',
                              maxLength: 10,
                              filled: false,
                              validator: Validate_Login,
                  keyboardType: TextInputType.number,

                            ),
                Text("You will recive an SMS verification that may apply\nmessage and data rates",
                style: robotoRegularGrey,
                ),
                const Spacer(),
                Center(
                  child: CustomButton(onTap: () {
                    if(mobile.text.length != 10 || mobile.text.isEmpty){
                      ("Please enter  Phone number", context, Colors.red);
                    }else{
                      authProvider.userLogin(context, mobile.text);
                    }
                  }, text: 'Get OTP',
                  textColor: Colors.white,
                  ),
                ),
                SizedBox(height: height*0.06,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String? Validate_Login(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

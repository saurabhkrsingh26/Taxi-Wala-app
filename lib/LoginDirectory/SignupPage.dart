import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/BaseButton.dart';
import 'package:taxiwala/Constant/dimensions.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/res/provider/aurthProvider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String phone = args["phone"];
    // var id = args["id"];
    //  String status =args["status"];
    // String error = args["error"];
    final height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
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
                SizedBox(height: height*0.1,),
                Text('Create Your account',
                  style: robotoExtraLarge,
                ),
                SizedBox(height: height*0.01,),

                const Text('Enter your Name and Email',
                  style: robotoBlack,
                ),
                SizedBox(height: height*0.025,),

                Constant_text_field(
                  controller: name,
                  keyboardType: TextInputType.name,
                  hintText: 'Name',
                  filled: false,
                  validator: Validate_Name,
                ),
                SizedBox(height:  height*0.025,),
                Constant_text_field(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  filled: false,
                  validator: Validate_Email,
                ),
                const Spacer(),
                Center(
                  child: CustomButton(
                    onTap: () {
                      setState(() {
                        _validate = name.text.isNotEmpty;
                        _validate = email.text.isNotEmpty;
                      });
                      if (_validate) {
                        authProvider.createUser(context, name.text, email.text,phone.toString());
                      }
                    }, text: 'Sign up',
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: height*0.05,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String? Validate_Name(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
  String? Validate_Email(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}

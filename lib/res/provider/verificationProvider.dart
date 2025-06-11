import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/model/authModel.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';

class VerificationProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  AuthModel? _loginResponse;
  AuthModel? get loginResponse => _loginResponse;

  ///otp send
  Otp_send(context, String phone) async {
    print(phone);
    print("hhhhhhhh");
    final response = await http.get(Uri.parse("https://otp.hopegamings.in/send_otp.php?mobile=$phone&digit=4&mode=test"));
    print("llllllllll");
    final data = jsonDecode(response.body);
    print("kkkkkkkkkk");
    if (data["error"] == "200") {
      print("mnbhgffddsffg");
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      print("jhgfgdsfghjk");
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
  ///   Verifey Otp
  Future verifyOtp(context, String phone, String otpCon,
      String id,String status) async {
    final response = await http.post(
      Uri.parse(
          "https://otp.hopegamings.in/verifyotp.php?mobile=$phone&otp=$otpCon"),
    );
    final data = jsonDecode(response.body);
    if (data["error"] == "200") {

      if(status == "0"){
        final userPref = Provider.of<UserViewProvider>(context, listen: false);
        userPref.saveUser(AuthModel(id: id.toString()));
        Navigator.pushReplacementNamed(context, RoutesName.Homepage);
      }
      else{
        Navigator.pushReplacementNamed(context, RoutesName.SignupPage,arguments: {
          "phone": phone,
          "error": data["error"],
          "id": data["id"],
          "status": data['status'].toString(),
        }
        );
      }
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      // Utils.showErrorToast('please enter valid otp');
    }
  }
}

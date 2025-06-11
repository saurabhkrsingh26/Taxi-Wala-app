import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/model/authModel.dart';


class BookingOtpProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  AuthModel? _loginResponse;
  AuthModel? get loginResponse => _loginResponse;
  ///otp send
  bookingOtp(context, String phone) async {
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
}

 // // ignore_for_file: depend_on_referenced_packages
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart'as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:taxiwala/Route/RouteNames.dart';
//
// class ApiController {
//   ///otp send
//   Otp_send(context, String phone) async {
//     print(phone);
//     print("hhhhhhhh");
//     final response = await http.get(Uri.parse(
//         "https://otp.hopegamings.in/send_otp.php?mobile=$phone&digit=4&mode=test"));
//     print("llllllllll");
//     final data = jsonDecode(response.body);
//     print("kkkkkkkkkk");
//     if (data["error"] == "200") {
//       print("mnbhgffddsffg");
//       Fluttertoast.showToast(
//         msg: data['msg'],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     } else {
//       print("jhgfgdsfghjk");
//       Fluttertoast.showToast(
//         msg: data['msg'],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }
// ///   Verifey Otp
//   Future verifyOtp(context, String phone, String otpCon,
//       String id,String error) async {
//     print(id);
//     print("hghghg");
//     print(otpCon);
//     print("otpCon");
//     final response = await http.post(
//       Uri.parse(
//           "https://otp.hopegamings.in/verifyotp.php?mobile=$phone&otp=$otpCon"),
//     );
//     final data = jsonDecode(response.body);
//     print("sssssss");
//     print(data);
//     if (data['error'] == '200') {
//       if(error== '400'){
//         Navigator.pushNamed(context, RoutesName.SignupPage);
//       }
//       else{
//         final prefs = await SharedPreferences.getInstance();
//         prefs.setString('id', id);
//         Navigator.pushNamed(context, RoutesName.Homepage);
//       }
//       Fluttertoast.showToast(
//         msg: data['msg'],
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     } else {
//       // Utils.showErrorToast('please enter valid otp');
//     }
//   }
// }
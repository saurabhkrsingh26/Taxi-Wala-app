import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/model/authModel.dart';
import 'package:taxiwala/res/apiUrl.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  AuthModel? _loginResponse;

  AuthModel? get loginResponse => _loginResponse;

  Future userLogin(context, String mobile) async {
    print("llllll");
    print(mobile);
    final response = await http.post(
      Uri.parse("https://taxiwala.myluckynumber.in/user_login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "phone": mobile,
      }),
    );
    final data = jsonDecode(response.body);
    print("pppppppppp");
    if (data["error"] == "200") {
      print("uuuuuuuu");
      Fluttertoast.showToast(
        msg: data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushReplacementNamed(context, RoutesName.Verification, arguments: {
        "phone": mobile,
        "id": data["data"]["id"],
        "status": data['status'].toString(),
      });
    } else {
      Navigator.pushReplacementNamed(context, RoutesName.Verification, arguments: {
        "phone": mobile,
        "id": "",
        "status": data['status'].toString(),
      });
      // if (data["status"] == "1") {
      //
      // } else {
      //   print("amna");
      // }
    }
  }

  /// For Signup Page Api
  Future createUser(context, String name,String email,String phone) async {
    final response = await http.post(
      Uri.parse(AppUrl.signup),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "phone": phone,
      }),
    );
    final data = jsonDecode(response.body);
    if (data["error"] == "200") {
      final userPref = Provider.of<UserViewProvider>(context, listen: false);
      userPref.saveUser(AuthModel(id: data['userid'].toString()));
      Navigator.pushReplacementNamed(context, RoutesName.Homepage);
     return Fluttertoast.showToast(
        msg: data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

    } else {
        print("amnannjnjnj");
      }
    }
  }

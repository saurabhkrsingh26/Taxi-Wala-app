// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/model/authModel.dart';
import 'package:taxiwala/res/apiUrl.dart';
import 'package:taxiwala/res/provider/profile_provider.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';

class UpdateProfile with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// For Update Profile Page Api
     UserViewProvider userViewProvider =UserViewProvider();
  Future editProfile(context ,String name,String email,String phone,String gender,String dob) async {
    AuthModel user = await userViewProvider.getUser();
    String userid=user.id.toString();
    print(userid);
    print("😊😊😊😊😊");
    print(name);
    print("llllll");
    print(email);
    final response = await http.post(
      Uri.parse(AppUrl.profileUpdate),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid":userid.toString(),
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dob": dob,

      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("pppppppppp");
    if (data["status"] == "200") {
      ProfileProvider profileProvider=ProfileProvider();
      profileProvider.userProfile(context);
      print("uuuuuuuu");
      Fluttertoast.showToast(
        msg: data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pushReplacementNamed(context, RoutesName.drawerpage);
    } else {
      print("amnannjnjnj");
    }
  }
}

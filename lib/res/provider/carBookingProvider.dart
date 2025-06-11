// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/model/authModel.dart';
import 'package:taxiwala/model/profile_model.dart';
import 'package:taxiwala/res/apiUrl.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';

class CarBookingProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserViewProvider userViewProvider = UserViewProvider();

  Future carBooking(
      BuildContext context,
      String fromlat,
      String fromlong,
      String tolat,
      String tolong,
      String carId,
      String calculatedPrice,
      String calculatedDistance,
      ) async {
    try {
      AuthModel user = await userViewProvider.getUser();
      String userid = user.id.toString();
      print(userid);
      print("dsfda");
      final response = await http.post(
        Uri.parse(AppUrl.bookingUser),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "userid": userid,
          "pickup_latitude": fromlat,
          "pickup_longitude": fromlong,
          "drop_latitude": tolat,
          "drop_longitude": tolong,
          "car_type_id": carId,
          "total_amount": calculatedPrice,
          "distance": calculatedDistance,
        }),
      );
      print("wseww");
      final data = jsonDecode(response.body);
      print(data);
      print("asdss");
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
        Navigator.pushNamed(context, RoutesName.RideSearching, arguments: {
          "userid": userid,
          "car_type_id": data["car_type"].toString(),
          "total_amount": calculatedPrice,
        });
      } else {
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        msg: 'Failed to book the car. Please try again later.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

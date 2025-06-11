// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/res/apiUrl.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';

import '../../model/carTypeModel.dart';

class CarTypeProvider with ChangeNotifier {
  UserViewProvider userViewProvider = UserViewProvider();
  List<CarTypeModel> _myReviewsItems = [];
  List<CarTypeModel> get myReviewsItems => _myReviewsItems;
  void setItems(List<CarTypeModel> myReviewsItems) {
    _myReviewsItems = myReviewsItems;
    notifyListeners();
  }
  Future<List<CarTypeModel>>carType() async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.carType ),
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        List<CarTypeModel> reviewsList = jsonList
            .map((jsonItem) => CarTypeModel.fromJson(jsonItem))
            .toList();
        return reviewsList;
      } else {
        throw Exception('Failed to load user data');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
}
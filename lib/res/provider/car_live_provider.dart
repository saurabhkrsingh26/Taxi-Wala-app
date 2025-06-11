import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/res/apiUrl.dart';
import '../../model/carLiveModel.dart';

class CarLiveProvider with ChangeNotifier {
  Future<List<CarLiveModel>> carLiveType(String lat, String long) async {
    try {
      final response = await http
          .get(
            Uri.parse("${AppUrl.carLive}latitude=$lat&longitude=$long"),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body)['data'];

        List<CarLiveModel> reviewsList = jsonList
            .map((jsonItem) => CarLiveModel.fromJson(jsonItem))
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taxiwala/res/apiUrl.dart';
import 'package:http/http.dart' as http;

class WhatsappViewProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
var Whatsapp;
Future<void> whatsappView(context) async {
  print("hhhdhhd");
  try {
    final response = await http.get(Uri.parse(AppUrl.whatsApp));
    final resData = jsonDecode(response.body);
    print(resData);
    print("kjhgfds");
    if (resData["error"] =="200") {
      print("lkkik");
       Whatsapp = resData["data"][0]["whatsapp"];
      print(Whatsapp);
      print("lkkik");
    } else {
      print("saurabh");
      return null;
    }
  } catch (error) {
    print("Error occurred: $error");
    // Handle error gracefully
  }
}

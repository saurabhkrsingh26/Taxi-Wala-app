
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxiwala/model/authModel.dart';


class UserViewProvider with ChangeNotifier {
  Future<bool> saveUser(AuthModel user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.id.toString());
    notifyListeners();
    return true;
  }

  Future<AuthModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    return AuthModel(id: token.toString());
  }

  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
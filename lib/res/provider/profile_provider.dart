// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/model/authModel.dart';
import 'package:taxiwala/res/apiUrl.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/res/provider/userViewProvider.dart';

import '../../model/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ProfileModel? _profileResponse;

  ProfileModel? get profileResponse => _profileResponse;

  setProfileData(ProfileModel profileModel) {
    _profileResponse = profileModel;
    notifyListeners();
  }
UserViewProvider userViewProvider =UserViewProvider();
  Future userProfile(context) async {
    AuthModel user = await userViewProvider.getUser();
    String userid=user.id.toString();
    final response = await http.get(
      Uri.parse("${AppUrl.profile}$userid"),
    );
    final resData = jsonDecode(response.body);
    if (resData["status"] == 200) {
      ProfileModel profileData = ProfileModel.fromJson(resData["data"]);
      Provider.of<ProfileProvider>(context, listen: false)
          .setProfileData(profileData);
      return ProfileModel.fromJson(resData["data"]);
    } else {
      // return null;
    }
  }
}

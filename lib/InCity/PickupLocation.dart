// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:http/http.dart' as http;
import 'package:taxiwala/Route/RouteNames.dart';

class PickupLocation extends StatefulWidget {
  const PickupLocation({super.key});

  @override
  State<PickupLocation> createState() => _PickupLocationState();
}

class _PickupLocationState extends State<PickupLocation> {
  TextEditingController searchCon = TextEditingController();
  String? location;
  var liveLocation;
  var SearchLocation;
  var searchedLocationLongitude;
  var searchedLocationLatitude;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: height * 0.01),
          Constant_text_field(
            controller: searchCon,
            keyboardType: TextInputType.name,
            hintText: 'Search address...',
            filled: true,
            width: width * 0.9,
            fillColor: Colors.grey[300],
            onChanged: (v) {
              _getSuggestions(searchCon.text);
            },
          ),
          SizedBox(
            height: height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.SaveLocation);
                  },
                  child: SizedBox(
                    width: width*0.24,
                    child: const Row(
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                      Text(
                        '   Home',
                        style: robotoBlack,
                      ),
                    ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width*0.25,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.card_travel,
                        size: 30,
                      ),
                      Text(
                        '   Work',
                        style: robotoBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width*0.32,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 30,
                      ),
                      Text(
                        '   Favourites',
                        style: robotoBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _suggestion.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                itemCount: _suggestion.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      getLatLngFromPlaceId(_suggestion[index]['place_id'],
                          _suggestion[index]['description']);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 20,
                          child: Icon(Icons.location_on_outlined),
                        ),
                        SizedBox(
                          width: 280,
                          child:  ListTile(
                            title: Text(_suggestion[index]['description']),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: height * 0.003,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: ColorConstant.WHITE_BACKGROUND,
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.ConfiurmLocation);
                },
                child: SizedBox(
                  height: height * 0.07,
                  width: width * 0.43,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.my_location,
                        size: 25,
                      ),
                      Text(
                        ' Current locaction',
                        style: robotoBlack,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.ConfiurmLocation);
                },
                child: SizedBox(
                  height: height * 0.07,
                  width: width * 0.46,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_location_alt_outlined,
                        size: 25,
                      ),
                      Text(
                        ' Set locaction on Map',
                        style: robotoBlack,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<dynamic> _suggestion = [];

  Future<void> _getSuggestions(String input) async {
    const apiKey =
        'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM';
    final endpoint = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey',
    );

    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'];

      if (kDebugMode) {
        print("Predictions: $predictions");
      }
      if (kDebugMode) {
        print("saaaaaaaaaaaaaaaaaa");
      }
      if (kDebugMode) {
        print(predictions);
      }
      setState(() {
        _suggestion = predictions.map((prediction) {
          final description = prediction['description'] as String;
          final placeId = prediction['place_id'] as String;
          return {'description': description, 'place_id': placeId};
        }).toList();
      });
    }
  }

  Future<Map<String, double>> getLatLngFromPlaceId(
      String placeId, String address) async {
    const apiKey = 'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM';
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      if (kDebugMode) {
        print("ashuuu");
      }
      if (kDebugMode) {
        print(decodedResponse);
      }
      if (decodedResponse['status'] == 'OK') {
        final location = decodedResponse['result']['geometry']['location'];
        searchedLocationLatitude = location['lat'];
        searchedLocationLongitude = location['lng'];
        if (searchedLocationLongitude != null &&
            searchedLocationLatitude != null) {
          final selectedData = {
            'locationName': address,
            'latitude': searchedLocationLatitude,
            'longitude': searchedLocationLongitude,
          };
          Navigator.pop(context, selectedData);
          _suggestion.clear();
        }

        return {
          'latitude': searchedLocationLatitude,
          'longitude': searchedLocationLongitude
        };
      } else {
        throw Exception(
            'Failed to fetch location details: ${decodedResponse['error_message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch location details: ${response.statusCode}');
    }
  }
}

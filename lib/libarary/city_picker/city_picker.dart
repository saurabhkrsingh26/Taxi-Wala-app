import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'model/city_model.dart';

class CityPicker extends StatefulWidget {
  final TextEditingController city;
  final InputDecoration? textFieldDecoration;
  final Color? dialogColor;


  const CityPicker(
      {super.key,
      required this.city,
      this.textFieldDecoration,
      this.dialogColor,
      });

  @override
  State<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  final List<CityModel> _cityList = [];
  List<CityModel> _citySubList = [];
  String _title = '';

  @override
  void initState() {
    super.initState();
    _getCity();
  }

  Future<void> _getCity() async {
    // _cityList.clear();
    var jsonString = await rootBundle.loadString('assets/json/city.json');
    List<dynamic> body = json.decode(jsonString);

    _cityList
        .addAll(body.map((dynamic item) => CityModel.fromJson(item)).toList());
    // print('body');
    _citySubList = List.from(_cityList); // Ensure _citySubList is updated
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height:height*0.04,
            width: width*0.4,
            child: Center(
              child: TextField(
                controller: widget.city,
                style: robotoMediumExtraWhite,
                onTap: () {
                  setState(() => _title = 'Select City');

                  _showDialog(context, chooseName: 'Select City');
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5,5,15,5),
                  border: InputBorder.none,
                  hintText: "       Select City",
                  hintStyle: TextStyle(color: ColorConstant.RED_COLOR),
                ),
                readOnly: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, {required String chooseName}) {
    final TextEditingController cityController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      context: context,
      pageBuilder: (context, _, __) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: widget.dialogColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chooseName,
                              style: robotoRegular.copyWith(
                                  fontSize: width * 0.04, color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                  widget.city.text = cityController.text;
                                cityController.clear();
                                  setState(() {});
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Icon(
                                  Icons.cancel_rounded,
                                  size: 25,
                                  color: Colors.pink,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      ///Text Field
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextField(
                          controller: cityController,
                            onChanged: (val) {
                              setState(() {
                                _citySubList = _cityList
                                    .where((element) => element.name
                                    .toLowerCase()
                                    .contains(val.toLowerCase()))
                                    .toList();
                              });
                            },
                          style: robotoRegular.copyWith(
                              fontSize: width * 0.04, color: Colors.black),
                          // decoration: dropDownDecoration(
                          //     label: "Search here...",
                          //     prefix: const Icon(Icons.search))
                        ),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          itemCount: _citySubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  widget.city.text = _citySubList[index].name;
                                  _citySubList = _cityList; // Reset _citySubList to original list
                                });
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 10.0, right: 10.0),
                                child: Text(_citySubList[index].name,
                                    style: robotoRegular.copyWith(
                                        fontSize: width * 0.04,
                                        color: Colors.black)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

}

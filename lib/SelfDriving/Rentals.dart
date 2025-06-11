import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/SelfDriving/Date.dart';
import 'package:taxiwala/SelfDriving/Time.dart';
import 'package:taxiwala/libarary/city_picker/city_picker.dart';

class Rentals extends StatefulWidget {
  const Rentals({Key? key}) : super(key: key);

  @override
  State<Rentals> createState() => _RentalsState();
}

class _RentalsState extends State<Rentals> {
  DateTime pickupInitialDate = DateTime.now();
  DateTime dropInitialDate = DateTime.now();
  TimeOfDay? selectedPickTime;
  TimeOfDay? selectedDropTime;

  void _handlePickupDateSelected(DateTime date) {
    setState(() {
      pickupInitialDate = date;
      pickDateCon.text = formattedDate(pickupInitialDate);
    });
  }

  void _handleDropDateSelected(DateTime date) {
    setState(() {
      dropInitialDate = date;
      dropDateCon.text = formattedDate(dropInitialDate);
    });
  }

  @override
  void initState() {
    super.initState();
    pickDateCon.text = formattedDate(pickupInitialDate);
    dropDateCon.text = formattedDate(dropInitialDate);
  }

  String formattedDate(DateTime dateTime) {
    final String year = dateTime.year.toString();
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String day = dateTime.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  final pickDateCon = TextEditingController();
  final dropDateCon = TextEditingController();
  final cityCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            height: 200,
             width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/gif/commingsoon.gif"),
              )
            ),

                ),
        ),
      ],
    );
      Column(
      children: [
        Divider(color: Colors.transparent,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.06,
              width: width * 0.45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.Black_COLOR,
              ),
              child: const Center(
                child: Text(
                  'Pick up location',
                  style: robotoMediumExtraWhite,
                ),
              ),
            ),
            // Container(
            //     // height: height * 0.08,
            //     width: width * 0.45,
            //     color: Colors.black,
            //     child:
            // ),
            Container(
              height: height * 0.06,
              width: width * 0.45,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.Black_COLOR,
              ),
              child:CityPicker(city: cityCon),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.05,
          child: const Padding(
            padding: EdgeInsets.only(right: 260),
            child: Center(
              child: Text(
                'Pick up',
                style: robotoMediumBlack,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.065,
              width: width * 0.45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.WHITE_BACKGROUND,
              ),
              child: Center(
                child: DatePickerWidget(
                  controller: pickDateCon,
                  initialDate: pickupInitialDate,
                  onDateSelected: _handlePickupDateSelected,
                ),
              ),
            ),

            Container(
              height: height * 0.065,
              width: width * 0.45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.WHITE_BACKGROUND,
              ),
              child:  GestureDetector(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: selectedPickTime ?? TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    setState(() {
                      selectedPickTime = pickedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
                child: Center(
                  child: Text(
                    selectedPickTime != null
                        ? "${selectedPickTime!.hour}:${selectedPickTime!.minute}"
                        : "Select Time",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

          ],
        ),
        SizedBox(
          height: height * 0.05,
          child: const Padding(
            padding: EdgeInsets.only(right: 280),
            child: Center(
              child: Text(
                'Drop',
                style: robotoMediumBlack,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: height * 0.065,
              width: width * 0.45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.WHITE_BACKGROUND,
              ),
              child: Center(
                child: DatePickerWidget(
                  controller: dropDateCon,
                  initialDate: dropInitialDate,
                  onDateSelected: _handleDropDateSelected,
                ),
              ),
            ),
            Container(
              height: height * 0.065,
              width: width * 0.45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstant.WHITE_BACKGROUND,
              ),
              child:  GestureDetector(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: selectedDropTime ?? TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    setState(() {
                      selectedDropTime = pickedTime;
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
                child: Center(
                  child: Text(
                    selectedDropTime != null
                        ? "  ${selectedDropTime!.hour}:${selectedDropTime!.minute}"
                        : "Select Time",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

          ],
        ),
        SizedBox(height: height * 0.02),
        ColorButton(
          onTap: () {
            Navigator.pushNamed(context, RoutesName.selfdriving);
          },
          text: 'Search',
          btnColor: ColorConstant.Black_COLOR,
          textColor: ColorConstant.WHITE_COL0R,
        ),
      ],
    );
  }
}

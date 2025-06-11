import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class DatePickerWidget extends StatefulWidget {
  final TextEditingController controller;
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({
    required this.controller,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime selectedDate;
  late DateTime selectedDatee;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    selectedDatee = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1800),
      lastDate: DateTime(2101),
    );


    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedDatee = picked;

        widget.onDateSelected(selectedDate); // Callback to the parent widget
        widget.onDateSelected(selectedDatee); // Callback to the parent widget
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return
      TextFormField(

          onTap: ()=>_selectDate(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some amount';
            }
            return null;
          },
          style: robotoMediumBlack.copyWith(fontSize: width*0.04, color: Colors.black),

        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 1),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Color(0xFFF65054)),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Color(0xFFF65054)),
          ),
          hintText: "Date",
          suffix: Icon(Icons.arrow_drop_down,size: 30,),
        ),
        maxLength: 10,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        readOnly: true,

      );

  }
}
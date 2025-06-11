import 'package:flutter/material.dart';

class Custom_pin_field extends StatefulWidget {
  final int pinLength;
  final List<TextEditingController>? controllers;
  Custom_pin_field({this.pinLength = 4, this.controllers});
  @override
  _Custom_pin_fieldState createState() => _Custom_pin_fieldState();
}

class _Custom_pin_fieldState extends State<Custom_pin_field> {
  List<FocusNode> _focusNodes = [];
  List<String> _pinValues = [];

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.pinLength, (index) => FocusNode());
    _pinValues = List.generate(widget.pinLength, (index) => '');
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.pinLength; i++) {
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _nextField(int index, String value) {
    if (index < widget.pinLength - 1) {
      _focusNodes[index].unfocus();
      _focusNodes[index + 1].requestFocus();
    } else if (index == widget.pinLength - 1) {
      _focusNodes[index].unfocus();
    }
    setState(() {
      _pinValues[index] = value;
    });
  }

  void _previousField(int index) {
    if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLength, (index) {
        return Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: widget.controllers != null
                ? widget.controllers![index]
                : null,
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            obscureText: false,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1) {
                _nextField(index, value);
              } else {
                _previousField(index);
              }
            },
          ),
        );
      }),
    );
  }
}
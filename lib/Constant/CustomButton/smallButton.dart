


import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/fontstyle.dart';

class ColorButton extends StatefulWidget {
  const ColorButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.btnColor,
    required this.textColor,
    this.border,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Ink(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Container(
            width: 140,
            height: 50,
            decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(
                10,
              ),
              border: widget.border,
            ),
            child: Center(
              child: Text(
                  widget.text,
                  style: robotoWhite
              ),
            ),
          ),
        ),
      ),
    );
  }
}
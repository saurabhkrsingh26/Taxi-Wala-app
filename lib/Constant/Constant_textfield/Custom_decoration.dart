import 'package:flutter/material.dart';
import 'package:taxiwala/Constant/fontstyle.dart';


InputDecoration getInputDecoration(String hintText,
    // SuffixData
    ) {
  return InputDecoration(
    counter: const Offstage(),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.black, width: 1),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.black, width: 1),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
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
    filled: true,
    prefix: Text("+91",style:robotoRegular),

    // suffixIcon: SuffixData,
    hintStyle: robotoRegular.copyWith(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),



  );

}
import 'package:flutter/material.dart';

InputDecoration dropdownStyle(String labelText) {
  return InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
  );
}

TextStyle myTextStyle(){
  return const TextStyle(
    fontSize: 20.0,
    color: Colors.red,
    fontWeight: FontWeight.bold
  );
}
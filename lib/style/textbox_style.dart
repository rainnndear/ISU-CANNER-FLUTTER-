import 'package:flutter/material.dart';

InputDecoration textBoxStyle(String hintText, String label) {
  return InputDecoration(
    hintText: hintText,
    label: Text(label),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
    )
  );
}

TextStyle myTextStyle(){
  return const TextStyle(
    fontSize: 20.0,
    color: Colors.red,
    fontWeight: FontWeight.bold
  );
}
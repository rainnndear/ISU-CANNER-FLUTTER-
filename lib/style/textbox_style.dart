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


InputDecoration greenInputDecoration(String labelText, String hintText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.green), // Change label text to green
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.green), // Change hint text to green
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2.0), // Green border when not focused
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2.0), // Green border when focused
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0), // Red border for error state
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
    suffixIconColor: Colors.green, // Suffix icon color
  );
}

InputDecoration greenInputDecoration1({required String labelText, required String hintText}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.green), // Change label text to green
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.green), // Change hint text to green
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2.0), // Green border when not focused
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 2.0), // Green border when focused
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0), // Red border for error state
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2.0),
    ),
    suffixIconColor: Colors.green, // Suffix icon color
  );
}






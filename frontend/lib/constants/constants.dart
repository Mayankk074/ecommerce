import 'package:flutter/material.dart';

const InputDecorationTheme textInputDecoration= InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  // hintText: "Enter you product name",
  border: OutlineInputBorder(
     borderRadius:  BorderRadius.all(Radius.circular(10.0))
  ),
  filled: true,
  fillColor: Colors.white,
);

const ButtonStyle buttonStyle=ButtonStyle(
  foregroundColor: WidgetStatePropertyAll(Colors.black)
);
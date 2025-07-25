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

//using constant baseUrl so it can be used anywhere from here

//for local machine
// const String baseUrl= 'http://192.168.29.135:8080';

//for render (online server host)
const String baseUrl= 'https://ecommerce-yhec.onrender.com';
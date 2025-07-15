
import 'package:ecommerce/page/auth/Authenticate.dart';
import 'package:ecommerce/page/auth/login.dart';
import 'package:ecommerce/page/auth/register.dart';
import 'package:ecommerce/page/auth/wrapper.dart';
import 'package:ecommerce/page/home/homebody/productDetails.dart';
import 'package:ecommerce/service/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';
//creating a single Authservice object so it will create s single stream to which we will listen
//and will use across all pages
Authservice authservice=Authservice();
void main() {
  runApp(MyApp(authservice: authservice,));
}

class MyApp extends StatefulWidget {
  final Authservice authservice;
  const MyApp({super.key, required this.authservice});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: widget.authservice.authStateChanges,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            // ···
            brightness: Brightness.dark,
          ),
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              // hintText: "Enter you product name",
              border: OutlineInputBorder(
                  borderRadius:  BorderRadius.all(Radius.circular(30.0))
              ),
            fillColor: Colors.white,
            filled: true,
            prefixIconColor: Colors.black,
            hintStyle: TextStyle(
              color: Colors.black,
            ),
          ),
            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: const TextTheme(
              titleSmall: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black
              ),
            ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              foregroundColor: const WidgetStatePropertyAll(Colors.black)
            )
          )
        ),
        home: Wrapper(authservice: widget.authservice,),
        routes: {
          "/wrapper": (context) => Authenticate(authservice: widget.authservice,),
          "/login": (context) => Login(authservice: widget.authservice,),
          "/register": (context) => Register(authservice: widget.authservice),
          "/productDetails": (context) => ProductDetails(),
        },
      ),
    );
  }
}

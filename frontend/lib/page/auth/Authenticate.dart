import 'package:flutter/material.dart';

import '../../service/authService.dart';

class Authenticate extends StatefulWidget {
  final Authservice authservice;
  const Authenticate({super.key, required this.authservice});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: ()async{
              // await widget.authservice.login("mayank", "test123");
              Navigator.pushNamed(context, "/login");
            },
            child: Text("Login"),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, "/register");
            },
            child: Text("Register")
          )
        ]
      ),
    );
  }
}

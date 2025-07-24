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
              Navigator.pushNamed(context, "/login");
            },
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(fixedSize: const WidgetStatePropertyAll(Size(300,60))),
            child: const Text("Login"),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, "/register");
            },
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(fixedSize: const WidgetStatePropertyAll(Size(300,60))),
            child: const Text("Register")
          )
        ]
      ),
    );
  }
}

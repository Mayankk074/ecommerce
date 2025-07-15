import 'package:ecommerce/service/authService.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class Register extends StatefulWidget {
  final Authservice authservice;
  const Register({super.key, required this.authservice});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey=GlobalKey<FormState>();
  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05, horizontal: screenWidth*0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(),
              const SizedBox(height: 20,),
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: const InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person)
                ),
                validator: (val) => val!.isEmpty ? "Enter username" : null,
                onChanged: (val) => setState(() => username = val)
              ),
              const SizedBox(height: 20,),
              TextFormField(
                style: Theme.of(context).textTheme.titleSmall,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock)
                ),
                validator: (val) => val!.isEmpty ? "Enter password" : null,
                onChanged: (val) => setState(() => password = val)
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()) {
                      try {
                        await widget.authservice.register(username!, password!);
                        const snackBar = SnackBar(content: Text('User has been created'));
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //Navigating to login page to get the JWT token.
                        if (context.mounted) Navigator.pushReplacementNamed(context, "/login");
                      }catch(e){
                        const snackBar = SnackBar(content: Text('Internal server error'));
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text("Create account")
              )
            ],
          ),
        ),
      ),
    );
  }
}

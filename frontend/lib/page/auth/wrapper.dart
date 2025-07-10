import 'package:ecommerce/service/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';
import '../home/home.dart';
import 'Authenticate.dart';

class Wrapper extends StatelessWidget {
  //using the same authservice object from main
  final Authservice authservice;
  const Wrapper({super.key, required this.authservice});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);

    print("user: $user");

    return user != null ? Home(): Authenticate(authservice: authservice,);
  }
}

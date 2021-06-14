import 'package:flutter/material.dart';
import 'package:planthut/models/user.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(user:user),
    );
  }
}

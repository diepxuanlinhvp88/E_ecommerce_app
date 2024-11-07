import 'package:flutter/material.dart';
import 'package:untitled/screen/authen/register.dart';
import 'package:untitled/screen/authen/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenState();
}

class _AuthenState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn =! showSignIn;
    });
  }

  @override
   build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView : toggleView );
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}

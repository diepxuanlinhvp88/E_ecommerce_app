import 'package:flutter/material.dart';
import 'package:untitled/shared/constants.dart';
import 'package:untitled/shared/loading.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {


    return loading? Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "Register", style: TextStyle(
          color: Colors.white,
          fontSize: 20,

        ),
        ),
        actions:<Widget> [
          TextButton(onPressed: (){
            widget.toggleView();

          }, child: Row(
            children: <Widget>[
              Icon(Icons.person),
              Text('Sign In')
            ],
          ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,

          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (value) => value == null || value.isEmpty ? 'Enter an email' : null,
                onChanged: (value) => setState(() => email = value),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (value) => value == null || value.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
              ),


              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic res = await _auth.registerWithEmail(email, password);
                    if(res == null){
                      setState(() {
                        error = 'error register';
                        loading = false;
                      });

                    }

                  }

              }, child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink
                ),
              ),
              SizedBox(height: 20,),
              Text(error,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 20,

              ),)
            ],
          ),
        ),
      ),
    );
  }
}

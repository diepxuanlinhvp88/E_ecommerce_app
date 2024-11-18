import 'package:flutter/material.dart';
import 'package:untitled/screen/authen/authenticate.dart';
import 'package:untitled/services/auth_service.dart';
import 'package:untitled/shared/loading.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(
          "SIGN IN BAR",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Row(
              children: <Widget>[Icon(Icons.person), Text('Register')],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
               decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter an email' : null,
                onChanged: (value) => {setState(() => email = value)},
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (value) => value == null || value.length < 6
                    ? 'Enter a password 6+ chars long'
                    : null,
                obscureText: true,
                onChanged: (value) => {setState(() => password = value)},
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic resul =
                        await _auth.signInWithEmailPass(email, password);
                    if (resul == null) {
                      setState(() {
                        error = 'error signin';
                        loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

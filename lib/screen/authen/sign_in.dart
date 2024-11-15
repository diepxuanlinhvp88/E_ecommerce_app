import 'package:flutter/material.dart';
import 'package:untitled/screen/authen/forgotPass.dart';
import 'package:untitled/services/provider/auth_notifier.dart';
import 'package:untitled/shared/loading.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  bool _isPasswordVisible = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFF8C68EE),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  toolbarHeight: 110.0,
                  title: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 138),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Hello,',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: kColumnPaddingDF),
                              Text(
                                'Login to your account',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: kColumnPaddingDF),
                        Text(
                          'E-mail*',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: kColumnPaddingDF - 1),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Please enter your email"),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter an email'
                              : null,
                          onChanged: (value) => {setState(() => email = value)},
                        ),
                        SizedBox(height: kColumnPaddingDF * 2),
                        Text(
                          'Password*',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          obscureText: !_isPasswordVisible,
                          validator: (value) =>
                              value == null || value.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                          onChanged: (value) =>
                              {setState(() => password = value)},
                          decoration: InputDecoration(
                            hintText: "Please enter your password",
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kColumnPaddingDF),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Forgotpass()));
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: kColumnPaddingDF * 2),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFA993A),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await authNotifier
                                  .signInWithEmailPass(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Incorrect email or password';
                                });
                              }
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color(0xFFFA993A),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.fingerprint, color: Colors.white),
                          onPressed: () {
                            print("Fingerprint login");
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kColumnPaddingDF,
                  ),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
  }
}

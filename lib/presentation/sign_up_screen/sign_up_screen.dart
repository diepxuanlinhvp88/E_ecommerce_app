import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_export.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

  void toggleView() {}
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  bool _acceptedMarketing = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthService>(context);

    return Scaffold(
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
              'Register',
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h * 3),
                Text(
                  'PERSONAL INFORMATION',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '*Please use English character only',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4.h * 2),

                // Nationality and Sex Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Nationality*',
                          border: OutlineInputBorder(),
                        ),
                        value: 'Vietnam',
                        items: ['Vietnam', 'England', 'America']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Color(0xFFFA993A)),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(width: 4.h * 2),
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Sex*',
                          border: OutlineInputBorder(),
                        ),
                        value: 'Male',
                        items: ['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Color(0xFFFA993A)),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h * 2),

                // Name Row
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First name*',
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          color: Color(0xFFFA993A),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.h * 2),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last name*',
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          color: Color(0xFFFA993A),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h * 2),

                // Email
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-mail*',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Color(0xFFFA993A),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password*',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(0xFFFA993A),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Please enter 6 chars";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Color(0xFFFA993A),
                  ),
                ),
                SizedBox(height: 4.h * 2),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password*',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Color(0xFFFA993A),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    } else if (value.length < 6) {
                      return "Please enter 6 chars";
                    }
                    if (value != _passwordController.text) {
                      print(_passwordController.text);
                      print("${value}sff");
                      return "Password do not match";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  style: TextStyle(
                    color: Color(0xFFFA993A),
                  ),
                ),
                SizedBox(height: 16),

                // Checkboxes
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'I hereby read and accepted the '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: ' of GlobalCart App'),
                      ],
                    ),
                  ),
                  value: _acceptedTerms,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'I agree to receive information about promotions and marketing e-mails from GlobalCart and partners',
                  ),
                  value: _acceptedMarketing,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptedMarketing = value ?? false;
                    });
                  },
                ),
                SizedBox(height: 16),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFA993A),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () async {
                      if (!_acceptedTerms || !_acceptedMarketing) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please accept Terms of Use'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        dynamic result = await authNotifier.signUp(email: email,password: password);

                      }
                    },
                    child: Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

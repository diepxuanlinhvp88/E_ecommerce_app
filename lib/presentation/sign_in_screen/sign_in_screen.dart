import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = '';
  String password = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String error = '';

  get authNotifier => null;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appTheme.deepPurpleA200,
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
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Hello,',
                          style: CustomTextStyles.headlineSmallOnPrimaryContainer,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Login to your account',
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer_1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E-mail*',
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                        SizedBox(height: 2.h),
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "Please enter your email",
                          textInputType: TextInputType.emailAddress,
                          contentPadding: EdgeInsets.all(10.h),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password*',
                          style: CustomTextStyles.bodyMediumOnPrimaryContainer,
                        ),
                        SizedBox(height: 2.h),
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "Please enter your password",
                          textInputType: TextInputType.emailAddress,
                          suffix: IconButton(
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
                          suffixConstraints: BoxConstraints(maxHeight: 40.h),
                          obscureText: _isPasswordVisible,
                          contentPadding: EdgeInsets.all(10.h),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> const Forgotpass()));
                },
                child: Text(
                  'Forgot password',
                  style: CustomTextStyles.bodyMediumPrimary,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: 'Sign In',
                    height: 50.h,

                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      _signIn(authService);
                    },
                  ),
                ),
                SizedBox(width: 10.h),
                Container(
                  width: 50,
                  height: 50,
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

            SizedBox(width: 12.h),
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
                      Navigator.pushNamed(context, AppRoutes.signUpScreen);
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

  Future<void> _signIn(AuthService authService) async {
    setState(() {
      loading = true;
      error = "";
    });

    try {
      await authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushNamed(context, AppRoutes.homeScreen); // Navigate to home screen on success
    } catch (e) {
      setState(() {
        error = e.toString();
      });
      print(error);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}



class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  final TextEditingController _emailController = TextEditingController();
  String? errorText;

  void _sendResetLink() async {
    final email = _emailController.text.trim();

    // Kiểm tra nếu email chưa nhập
    if (email.isEmpty) {
      setState(() {
        errorText = 'Email is required'; // Cập nhật lỗi nếu email trống
      });
      return;
    }

    // Kiểm tra nếu email không hợp lệ
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(email)) {
      setState(() {
        errorText = 'Invalid email address'; // Cập nhật lỗi nếu email không hợp lệ
      });
      return;
    }

    setState(() {
      errorText = null; // Đặt lại lỗi nếu email hợp lệ
    });

    // Lấy AuthNotifier từ context
    final authNotifier = Provider.of<AuthService>(context, listen: false);

    try {
      // Gọi phương thức gửi email reset từ AuthNotifier
      await authNotifier.sendPasswordResetEmail(email);

      // Lấy thông báo thành công từ AuthNotifier
      if (authNotifier.success != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authNotifier.success!)),
        );
      }

      // Đặt lại lỗi thành null sau khi gửi thành công
      setState(() {
        errorText = null;
      });

      // Đợi 3 giây rồi quay lại màn hình login
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);  // Quay lại màn hình trước đó
    } catch (e) {
      setState(() {
        errorText = 'Failed to send reset link. Please try again.'; // Cập nhật lỗi nếu có
      });

      // In lỗi ra console để kiểm tra
      print('Error sending reset email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),
              Image.asset('lib/assets/icons/key.png'),
              SizedBox(height: 12.h),
              Text(
                "Forgot Password ?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8C68EE),
                    fontSize: 18),
              ),
              Text(
                "No worries, we'll send a 6-digit code to your email ",
                style: TextStyle(fontSize: 13, color: Color(0xFF9DA4AE)),
              ),
              Text(
                "Enter code to reset your password.",
                style: TextStyle(fontSize: 13, color: Color(0xFF9DA4AE)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('E-mail*'),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  cursorColor: Colors.red,
                  style: TextStyle(color: Colors.red),
                ),
                if (errorText != null) // Nếu có lỗi, hiển thị lỗi
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorText!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                Row(children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: _sendResetLink,
                      child: Text(
                        "Send Code",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFFA993A)),
                    ),
                  ),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}

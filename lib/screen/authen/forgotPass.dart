import 'package:flutter/material.dart';
import 'package:untitled/services/provider/auth_notifier.dart';
import 'package:untitled/shared/constants.dart';
import 'package:provider/provider.dart';

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
        errorText = 'Email is required';
      });
      return;
    }

    // Kiểm tra nếu email không hợp lệ
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(email)) {
      setState(() {
        errorText = 'Invalid email address';
      });
      return;
    }

    setState(() {
      errorText = null;
    });

    // Lấy AuthNotifier từ context
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);

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
              SizedBox(height: kDefaultPaddin),
              Image.asset('lib/assets/icons/key.png'),
              SizedBox(height: kDefaultPaddin),
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
          SizedBox(height: kDefaultPaddin),
          Padding(
            padding: const EdgeInsets.all(kDefaultPaddin),
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

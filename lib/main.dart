import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/screen/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:untitled/services/provider/auth_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
        ),
        StreamProvider<CustomUser?>.value(
          value: AuthNotifier().user,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
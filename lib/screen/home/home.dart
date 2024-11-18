import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/screen/home/components/body.dart';

import 'package:untitled/services/provider/auth_notifier.dart';
import 'package:untitled/shared/constants.dart';

import 'dart:convert';

class Home extends StatelessWidget {
  Home({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // final AuthService _authService = AuthService();

    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    final AuthNotifier _authService = AuthNotifier();
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('lib/assets/icons/back.svg'),
        onPressed: () {
          _authService.signOut();
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () async {

          },
          icon:
              SvgPicture.asset('lib/assets/icons/cart.svg', color: kTextColor),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'lib/assets/icons/search.svg',
            color: kTextColor,
          ),
        ),
        SizedBox(
          height: kDefaultPaddin / 2,
        )
      ],
    );
  }
}

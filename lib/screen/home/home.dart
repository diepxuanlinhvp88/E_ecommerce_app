import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/screen/home/components/body.dart';
import 'package:untitled/services/auth.dart';
import 'package:untitled/shared/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('lib/assets/icons/back.svg'),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('lib/assets/icons/cart.svg',
              color: kTextColor),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'lib/assets/icons/search.svg',
            color: kTextColor,
          ),
        ),
        SizedBox(height: kDefaultPaddin /2,)
      ],
    );
  }
}

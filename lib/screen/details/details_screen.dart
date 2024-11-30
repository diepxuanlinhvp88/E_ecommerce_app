import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/screen/details/components/body.dart';
import 'package:untitled/shared/constants.dart';



class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8C68EE),
      appBar: AppBar(
        backgroundColor: Color(0xFF8C68EE),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'lib/assets/icons/back.svg',
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('lib/assets/icons/search.svg')),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('lib/assets/icons/cart.svg')),
          SizedBox(width: kDefaultPaddin,)
        ],
      ),
      body: Body(product: product),
    );
  }
}

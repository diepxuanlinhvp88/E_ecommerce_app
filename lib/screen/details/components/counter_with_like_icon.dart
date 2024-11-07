import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cart_counter.dart';

class CounterAndLikeButton extends StatelessWidget {
  const CounterAndLikeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
          ),
          child: SvgPicture.asset('lib/assets/icons/heart.svg'),
        )
      ],
    );
  }
}
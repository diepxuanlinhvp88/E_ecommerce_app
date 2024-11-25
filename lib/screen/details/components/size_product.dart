import 'package:flutter/material.dart';

import '../../../model/Product.dart';
import '../../../shared/constants.dart';

class sizeProduct extends StatelessWidget {
  const sizeProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: kDefaultPaddin,
        ),
        Row(
          children: <Widget>[
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: kTextColor,
                    ),
                    children: [
                  TextSpan(text: "Size\n"),
                  TextSpan(
                      text: "${product.rating} cm",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold))
                ]))
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../../shared/constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final void Function()? press;

  const ItemCard({
    super.key,
    required this.product,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
                padding: EdgeInsets.all(kDefaultPaddin),
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  color: Color(0xFF8C68EE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Hero(tag: "${product.product_id}",child: Image.network(product!.img_link))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product!.product_name,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product!.actual_price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../model/product.dart';
import '../../../shared/constants.dart';
class ProductTitleWithImage extends StatelessWidget {

  const ProductTitleWithImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tên sản phẩm",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product.product_name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: kDefaultPaddin,
          ),
          Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                    TextSpan(text: "price\n"),
                    TextSpan(
                        text: "\$${product.actual_price}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold))
                  ])),
              SizedBox(
                width: kDefaultPaddin,
              ),
              Expanded(
                child: Hero(
                  tag: "${product.product_id}",
                  child: Image.asset(
                    product.img_link,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
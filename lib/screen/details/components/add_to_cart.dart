import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/Product.dart';
import '../../../shared/constants.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPaddin),
      // horizontal: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: kDefaultPaddin,
          ),
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: product.color,
                )),
            child: IconButton(
              icon: SvgPicture.asset(
                'lib/assets/icons/add_to_cart.svg',color: product.color,),
              color: product.color,
              onPressed: () {},
            ),
          ),
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: Size(50, 50),
                    side: BorderSide(color: product.color),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    backgroundColor: product.color),
                onPressed: () {},
                child: Text(
                  "Buy Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
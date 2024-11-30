import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/screen/details/components/product_title_with_image.dart';
import 'package:untitled/screen/details/components/size_product.dart';
import 'package:untitled/shared/constants.dart';

import 'add_to_cart.dart';
import 'cart_counter.dart';
import 'counter_with_like_icon.dart';
import 'description.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                        top: size.height * 0.12, right: kDefaultPaddin),
                    // padding: EdgeInsets.all(20),
                    // height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: kDefaultPaddin/2,),
                        sizeProduct(product: product),

                        Description(product: product),
                        SizedBox(height: kDefaultPaddin/2,),
                        CounterAndLikeButton(),
                        SizedBox(height: kDefaultPaddin/2,),
                        AddToCart(product: product)
                      ],
                    )),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/Product.dart';
import 'package:untitled/model/reviews.dart';
import 'custom_rating_bar.dart';
import 'package:untitled/widgets/lib/model/reviews.dart';

class ProductCard extends StatelessWidget {
  ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 234.h,
        width: 175.h,
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomImageView(
              imagePath: product.img_link,
              height: 158.h,
              width: 130.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(
                  product.product_name,
                  maxLines: 2,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 8.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$${product.actual_price.toInt()}',
                        style: CustomTextStyles.labelLargePrimary
                            .copyWith(fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(left: 2.h),
                          child: Text(
                            '\$${product.discounted_price.toInt()}',
                            style: CustomTextStyles.labelLargePrimary.copyWith(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: appTheme.blueGray100,
                                color: appTheme.blueGray100,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      const Spacer(),

                  Text(
                    '${product.rating}',
                    style: TextStyle(fontSize: 14, color: appTheme.orangeA200),
                  ),
                  Icon(
                    Icons.star,
                    color: LightCodeColors().orangeA200,
                  ),
                  // Padding(
                  //     padding: EdgeInsets.only(left: 1.h),
                  //     child: CustomRatingBar(
                  //       ignoreGestures: true,
                  //       initialRating: product.rating,
                  //       color: appTheme.orangeA200,
                  //     )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

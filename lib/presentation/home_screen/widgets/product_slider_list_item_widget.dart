import 'package:flutter/cupertino.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/Product.dart';

class ProductSliderListItemWidget extends StatelessWidget {
  ProductSliderListItemWidget(this.product, {super.key});

  Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98.h,
      height: 116.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: product.img_link,
            height: 116.h,
            width: double.maxFinite,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                product.discount_percentage!,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.labelLargePrimary,
              ),
            ),
          )
        ],
      )
    );
  }
}
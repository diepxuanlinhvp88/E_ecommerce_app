import 'package:flutter/material.dart';

import '../../../model/Product.dart';
import '../../../shared/constants.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPaddin),
      child: Text(
        product.about_product,
        style: TextStyle(height: 1.5,
        ),
      ),
    );
  }
}
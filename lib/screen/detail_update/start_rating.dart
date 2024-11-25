import 'package:flutter/material.dart';
class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const StarRating({
    Key? key,
    required this.rating,
    this.size = 20,
    this.color = Colors.amber,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {

        if (index < rating.floor()) {
          return Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Icon(Icons.star, size: size, color: color),
          );
        }

        else if (index == rating.floor() && rating % 1 != 0) {
          return Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Stack(
              children: [
                Icon(Icons.star, size: size, color: Colors.grey[300]),
                ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: rating % 1,
                    child: Icon(Icons.star, size: size, color: color),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Icon(Icons.star, size: size, color: Colors.grey[300]),
        );
      }),
    );
  }
}
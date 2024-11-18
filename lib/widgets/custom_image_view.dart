import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (endsWith('png')) {
      return ImageType.png;
    } else {
      return ImageType.jpg;
    }
  }
}

enum ImageType {svg, png, jpg, unknown}

class CustomImageView extends StatelessWidget {
  const CustomImageView(
    {super.key, this.imagePath,
      this.height,
      this.width,
      this.color,
      this.fit,
      this.alignment,
      this.onTap,
      this.radius,
      this.margin,
      this.border,
      this.placeHolder = 'assets/images/image_not_found.png'});

  final String? imagePath;

  final double? height;

  final double? width;

  final Color? color;

  final BoxFit? fit;

  final String? placeHolder;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? margin;

  final BorderRadius? radius;

  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment!, child: _buildWidget(),)
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildCircleImage(),
      ),
    );
  }

  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SvgPicture.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            color: color,
          );
        case ImageType.jpg:
        case ImageType.png :
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }
    return const SizedBox();
  }
}
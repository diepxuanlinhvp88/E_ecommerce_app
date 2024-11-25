import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:untitled/model/reviews.dart';

class Product {
  final String product_id,
      product_name,
      about_product,
      product_link,
      discount_percentage;
  final double actual_price, rating, discounted_price;
  final int rating_count;
  final String user_id, img_link;

  final List<Review> reviews;

  final dynamic category;

  Product({
    required this.discount_percentage,
    required this.discounted_price,
    required this.product_id,
    required this.product_name,
    required this.category,
    required this.about_product,
    required this.actual_price,
    required this.rating,
    required this.rating_count,
    required this.user_id,
    required this.img_link,
    required this.product_link,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> datajson) {
    return Product(
      discount_percentage: datajson['discount_percentage'],
      discounted_price: (datajson['discounted_price'] as num).toDouble(),
      product_id: datajson['product_id'],
      product_name: datajson['product_name'],
      product_link: datajson['product_link'],
      about_product: datajson['about_product'],
      actual_price: (datajson['actual_price'] as num).toDouble(),
      rating: (datajson['rating'] as num).toDouble(),
      rating_count: (datajson['rating_count'] as num).toInt(),
      user_id: datajson['user_id'],
      img_link: datajson['img_link'],
      reviews: (datajson['reviews'] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
      category: datajson['category'],
    );
  }

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final List<Review> reviews = (data['reviews'] as List<dynamic>?)
        ?.map((item) => Review.fromMap(item as Map<String, dynamic>))
        .toList() ?? [];
    return Product(
        discount_percentage: data['discount_percentage'],
        discounted_price: data['discounted_price'],
        product_id: data['product_id'],
        product_name: data['product_name'],
        category: data['category'],
        about_product: data['about_product'],
        actual_price: data['actual_price'],
        rating: data['rating'],
        rating_count: data['rating_count'],
        user_id: doc.id,
        img_link: data['img_link'],
        product_link: data['product_link'],
        reviews: reviews);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'product_name': product_name,
      'img_link': img_link,
      'discounted_price': discounted_price,
      'actual_price': actual_price,
      'rating': rating,
      'rating_count': rating_count,
      'about_product': about_product,
      'discount_percentage': discount_percentage,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'category': category,
    };
  }
}

Future<List<Product>> loadJsonFromAssets() async {
  try {
    final jsonString = await rootBundle.loadString('lib/assets/data .json');

    final jsonData = json.decode(jsonString);
    final products = (jsonData as List<dynamic>)
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
    return products;
  } catch (e) {
    print('Lỗi khi đọc file: $e');
    return [];
  }
}

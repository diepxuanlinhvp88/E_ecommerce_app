import 'dart:convert';

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
      reviews:
          (datajson['reviews'] as List) // Chuyển từ JSON thành danh sách Review
              .map((reviewJson) => Review.fromJson(reviewJson))
              .toList(),
      category: datajson['category'],
    );
  }

  // Phương thức toJson để chuyển đối tượng Product thành JSON
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
      // Chuyển mỗi Review thành JSON
      'category': category,
      // Nếu cần, bạn có thể chuyển category thành JSON tương tự
    };
  }
}

List<Product> products = [
  Product(
      product_id: "B07JW9H4J1",
      product_name:
          "Wayona Nylon Braided USB to Lightning Fast Charging and Data Sync Cable Compatible for iPhone 13, 12,11, X, 8, 7, 6, 5, iPad Air, Pro, Mini (3 FT Pack of 1, Grey)",
      category: [
        "Computers&Accessories",
        "Accessories&Peripherals",
        "Cables&Accessories",
        "Cables",
        "USBCables"
      ],
      actual_price: 650.0,
      discounted_price: 289,
      discount_percentage: "56%",
      rating: 4.2,
      rating_count: 24269,
      about_product:
          "High Compatibility : Compatible With iPhone 12, 11, X/XsMax/Xr ,iPhone 8/8 Plus,iPhone 7/7 Plus,iPhone 6s/6s Plus,iPhone 6/6 Plus,iPhone 5/5s/5c/se,iPad Pro,iPad Air 1/2,iPad mini 1/2/3,iPod nano7,iPod touch and more apple devices.|Fast Charge&Data Sync : It can charge and sync simultaneously at a rapid speed, Compatible with any charging adaptor, multi-port charging station or power bank.|Durability : Durable nylon braided design with premium aluminum housing and toughened nylon fiber wound tightly around the cord lending it superior durability and adding a bit to its flexibility.|High Security Level : It is designed to fully protect your device from damaging excessive current.Copper core thick+Multilayer shielding, Anti-interference, Protective circuit equipment.|WARRANTY: 12 months warranty and friendly customer services, ensures the long-time enjoyment of your purchase. If you meet any question or problem, please don't hesitate to contact us.",
      user_id:
          "AG3D6O4STAQKAY2UVGEUV46KN35Q,AHMY5CWJMMK5BJRBBSNLYT3ONILA,AHCTC6ULH4XB6YHDY6PCH2R772LQ,AGYHHIERNXKA6P5T7CZLXKVPT7IQ,AG4OGOFWXJZTQ2HKYIOCOY3KXF2Q,AENGU523SXMOS7JPDTW52PNNVWGQ,AEQJHCVTNINBS4FKTBGQRQTGTE5Q,AFC3FFC5PKFF5PMA52S3VCHOZ5FQ",
      img_link:
          "https://m.media-amazon.com/images/I/41Bnylq337S._SX300_SY300_QL70_FMwebp_.jpg",
      product_link:
          "https://www.amazon.in/Wayona-Braided-WN3LG1-Syncing-Charging/dp/B07JW9H4J1/ref=sr_1_1?qid=1672909124&s=electronics&sr=1-1",
      reviews: [
        Review(
            review_id: "R3HXWT0LRP0NMF",
            review_title: "Satisfied",
            review_content: "Looks durable Charging is fine tooNo complains",
            user_name: "Manav"),
        Review(
            review_id: "R2AJM3LFTLZHFO",
            review_title: "Charging is really fast",
            review_content: "Charging is really fast",
            user_name: "Adarsh gupta"),
        Review(
            review_id: "R6AQJGUP6P86",
            review_title: "Value for money",
            review_content: " good product.",
            user_name: "Sundeep"),
        Review(
            review_id: "R1KD19VHEDV0OR",
            review_title: "Product review",
            review_content: "Till now satisfied with the quality.",
            user_name: "S.Sayeed Ahmed"),
        Review(
            review_id: "R3C02RMYQMK6FC",
            review_title: "Good quality",
            review_content:
                "This is a good product . The charging speed is slower than the original iPhone cable",
            user_name: "jaspreet singh"),
      ]),
];

Future<List<Product>> loadJsonFromAssets() async {
  try {
    // Đọc file JSON từ assets
    final jsonString = await rootBundle.loadString('lib/assets/data .json');

    // Parse chuỗi JSON
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

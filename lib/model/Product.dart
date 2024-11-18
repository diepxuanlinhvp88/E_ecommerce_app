import 'package:flutter/material.dart';

class Product {
  final String product_id,
      product_name,
      about_product,
      product_link,
      discount_percentage;
  final double actual_price, rating, discounted_price;
  final int rating_count;
  final String user_id, img_link;
  final dynamic reviews;
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
      discounted_price :  289,
      discount_percentage: "56%",
      rating: 4.2,
      rating_count: 24269,
      about_product:
          "High Compatibility : Compatible With iPhone 12, 11, X/XsMax/Xr ,iPhone 8/8 Plus,iPhone 7/7 Plus,iPhone 6s/6s Plus,iPhone 6/6 Plus,iPhone 5/5s/5c/se,iPad Pro,iPad Air 1/2,iPad mini 1/2/3,iPod nano7,iPod touch and more apple devices.|Fast Charge&Data Sync : It can charge and sync simultaneously at a rapid speed, Compatible with any charging adaptor, multi-port charging station or power bank.|Durability : Durable nylon braided design with premium aluminum housing and toughened nylon fiber wound tightly around the cord lending it superior durability and adding a bit to its flexibility.|High Security Level : It is designed to fully protect your device from damaging excessive current.Copper core thick+Multilayer shielding, Anti-interference, Protective circuit equipment.|WARRANTY: 12 months warranty and friendly customer services, ensures the long-time enjoyment of your purchase. If you meet any question or problem, please don't hesitate to contact us.",
      user_id:
          "AG3D6O4STAQKAY2UVGEUV46KN35Q,AHMY5CWJMMK5BJRBBSNLYT3ONILA,AHCTC6ULH4XB6YHDY6PCH2R772LQ,AGYHHIERNXKA6P5T7CZLXKVPT7IQ,AG4OGOFWXJZTQ2HKYIOCOY3KXF2Q,AENGU523SXMOS7JPDTW52PNNVWGQ,AEQJHCVTNINBS4FKTBGQRQTGTE5Q,AFC3FFC5PKFF5PMA52S3VCHOZ5FQ",
      img_link:
          "https://m.media-amazon.com/images/I/310mw9KTJvL._SY300_SX300_QL70_FMwebp_.jpg",
      product_link:
          "https://www.amazon.in/Wayona-Braided-WN3LG1-Syncing-Charging/dp/B07JW9H4J1/ref=sr_1_1?qid=1672909124&s=electronics&sr=1-1",
      reviews: [
        {
          "review_id": "R3HXWT0LRP0NMF",
          "review_title": "Satisfied",
          "review_content": "Looks durable Charging is fine tooNo complains",
          "user_name": "Manav"
        },
        {
          "review_id": "R2AJM3LFTLZHFO",
          "review_title": "Charging is really fast",
          "review_content": "Charging is really fast",
          "user_name": "Adarsh gupta"
        },
        {
          "review_id": "R6AQJGUP6P86",
          "review_title": "Value for money",
          "review_content": " good product.",
          "user_name": "Sundeep"
        },
        {
          "review_id": "R1KD19VHEDV0OR",
          "review_title": "Product review",
          "review_content": "Till now satisfied with the quality.",
          "user_name": "S.Sayeed Ahmed"
        },
        {
          "review_id": "R3C02RMYQMK6FC",
          "review_title": "Good quality",
          "review_content":
              "This is a good product . The charging speed is slower than the original iPhone cable",
          "user_name": "jaspreet singh"
        },
        {
          "review_id": "R39GQRVBUZBWGY",
          "review_title": "Good product",
          "review_content": "Good quality",
          "user_name": "Khaja moin"
        },
        {
          "review_id": "R2K9EDOE15QIRJ",
          "review_title": "Good Product",
          "review_content": " would recommend",
          "user_name": "Anand"
        },
        {
          "review_id": "R3OI7YT648TL8I",
          "review_title": "As of now seems good",
          "review_content":
              "https://m.media-amazon.com/images/W/WEBP_402378-T1/images/I/81---F1ZgHL._SY88.jpg",
          "user_name": "S.ARUMUGAM"
        }
      ]),

];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

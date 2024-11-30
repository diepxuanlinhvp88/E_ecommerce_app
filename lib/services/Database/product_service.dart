import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../firebase_options.dart';
import '../../model/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//create
  Future<void> uploadProducts(String jsonFilePath) async {
    try {
      final String response = await rootBundle.loadString(jsonFilePath);
      final List<dynamic> data = jsonDecode(response);
      if (data.isEmpty) {
        print('No data found in the JSON file.');
        return;
      }

      for (var product in data) {
        if (product is Map<String, dynamic>) {
          await _firestore.collection('products').add(product);
        } else {
          print('Invalid product format: $product');
        }
      }

      print('Upload successful!');
    } catch (e) {
      print('Error uploading products: $e');
    }
  }
//read
  Future<List<Product>> fetchAllProducts() async {
    try {
      //querry
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      print('querry data thanh cong');

      //change
      return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
//update
  Future<void> update() async {
    final collection = FirebaseFirestore.instance.collection('products');
    final querySnapshot = await collection.get();

    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      final discountString = data['discount_percentage'] ?? '0';
      final discountValue =
          double.tryParse(discountString.replaceAll('%', '').trim()) ?? 0.0;

      await doc.reference.update({'seller_id': 'sellerAll'});
      await doc.reference.update({'stock': 50});
    }
  }
  //getTrendingLists
  Future<List<Product>> getTrendingProducts() async {
    try {
      //top 5 rating
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('rating', descending: true)
          .limit(8)
          .get();

      List<Product> trendingProducts = querySnapshot.docs.map((doc) {
        return Product.fromJson(doc.data());
      }).toList();

      return trendingProducts;
    } catch (e) {
      print('Error fetching trending products: $e');
      return [];
    }
  }
  //getSaleList
  Future<List<Product>> getSaleProductList() async {
    try {
      //top 5 rating
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .orderBy('discountPercentage', descending: true)
          .limit(8)
          .get();

      List<Product> saleProducts = querySnapshot.docs.map((doc) {
        return Product.fromJson(doc.data());
      }).toList();


      return saleProducts;
    } catch (e) {
      print('Error fetching sale products: $e');
      return [];
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Tạo đối tượng DatabaseService
  final productdb = ProductService();

  const jsonFilePath = 'lib/assets/data .json';

  try {
    await productdb.update();
  } catch (e) {
    print('Failed to upload products: $e');
  }
}

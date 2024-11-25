import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../firebase_options.dart';
import '../../model/Product.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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


}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Khởi tạo Firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // Tạo đối tượng DatabaseService
//   final databaseService = DatabaseService();
//
//   const jsonFilePath = 'lib/assets/data .json';
//
//   try {
//     await databaseService.uploadProducts(jsonFilePath);
//   } catch (e) {
//     print('Failed to upload products: $e');
//   }
// }

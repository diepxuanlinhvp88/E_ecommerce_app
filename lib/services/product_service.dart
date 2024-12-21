import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../firebase_options.dart';
import '../../model/product.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//read
  Future<List<Product>> fetchAllProducts() async {
    try {
      //querry
      QuerySnapshot snapshot = await _firestore.collection('amazon_products').limit(50).get();
      print('querry data thanh cong');

      //change
      return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      final productsCollection = FirebaseFirestore.instance.collection('amazon_products');

      // Truy vấn sản phẩm theo category_id
      final querySnapshot = await productsCollection
          .where('category_id', isEqualTo: categoryId)
          .get();

      // Chuyển đổi dữ liệu thành danh sách Product
      return querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (e) {
      print('Failed to fetch products by category: $e');
      return [];
    }
  }

  Future<List<Product>> fetchProductsByName(String template) async {
    try {
      final productsCollection = FirebaseFirestore.instance.collection('amazon_products');

      // Chuyển template sang chữ thường để tìm kiếm không phân biệt chữ hoa, chữ thường
      final templateLowercase = template.toLowerCase();

      // Truy vấn sản phẩm theo tên chứa `template`
      final querySnapshot = await productsCollection
          .where('title', isGreaterThanOrEqualTo: templateLowercase)
          .where('title', isLessThanOrEqualTo: '$templateLowercase\uf8ff')
          .get();

      // Chuyển đổi dữ liệu thành danh sách Product
      return querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (e) {
      print('Failed to fetch products by name: $e');
      return [];
    }
  }


  //getTrendingLists
  Future<List<Product>> getTrendingProducts() async {
    try {
      //top 5 rating
      final querySnapshot = await FirebaseFirestore.instance
          .collection('amazon_products')
          .orderBy('rating_count', descending: true)
          .limit(8)
          .get();

      List<Product> trendingProducts = querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc);
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
          .collection('amazon_products')
          .orderBy('discount_percentage', descending: true)
          .limit(8)
          .get();

      List<Product> saleProducts = querySnapshot.docs.map((doc) {
        return Product.fromFirestore(doc);
      }).toList();


      return saleProducts;
    } catch (e) {
      print('Error fetching sale products: $e');
      return [];
    }
  }
}


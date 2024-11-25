import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');

  Future updateUserData(String sugar, String name, int strength) async {
    return await collectionReference
        .doc(uid)
        .set({'sugar': sugar, 'name': name, 'strength': strength});
  }

  Future<void> uploadProducts(String jsonFilePath) async {
    try {
      // Đọc file JSON từ assets
      final String response = await rootBundle.loadString(jsonFilePath);
      final List<dynamic> data = jsonDecode(response);

      // Lặp qua từng sản phẩm và upload lên Firestore
      for (var product in data) {
        await _firestore.collection('products').add(product);
      }

      print('Upload successful!');
    } catch (e) {
      print('Error uploading products: $e');
    }
  }
}
void main() async{
  await DatabaseService( uid: 'abc').uploadProducts('lib/assets/data .json');


}

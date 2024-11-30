import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  Future<void> createUserProfile(CustomUser user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
      print('User profile created successfully!');
    } catch (e) {
      print('Error creating user profile: $e');
      throw e;
    }
  }
  // read
  Future<CustomUser?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return CustomUser.fromMap(doc.data()!);
      } else {
        print('User profile not found.');
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      throw e;
    }
  }

  // update
  Future<void> updateUserProfile(String uid, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(uid).update(updatedData);
      print('User profile updated successfully!');
    } catch (e) {
      print('Error updating user profile: $e');
      throw e;
    }
  }
}

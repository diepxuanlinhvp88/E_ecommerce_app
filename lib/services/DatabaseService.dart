import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('user');



  Future updateUserData(String sugar, String name, int strength) async{
    return await collectionReference.doc(uid).set({
      'sugar': sugar,
      'name' : name,
      'strength' : strength

    });

  }
}
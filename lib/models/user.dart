import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String type;
  final String password;

  UserModel({this.uid, this.email, this.type, this.password});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      return null;
    } else {
      return UserModel(uid: doc.id, email: doc['email'], type: doc['type']);
    }
  }
}

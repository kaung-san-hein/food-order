import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order/src/models/user.dart';

class UserServices {
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(Map<String, dynamic> value) async {
    await _users.doc(value['id']).set(value);
  }

  Future<void> updateUser(Map<String, dynamic> value) async {
    await _users.doc(value['id']).update(value);
  }

  Future<UserModel> getUserById(String id) async {
    return await _users
        .doc(id)
        .get()
        .then((snapshot) => UserModel.fromSnapshot(snapshot));
  }
}

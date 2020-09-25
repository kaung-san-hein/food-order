import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = 'id';
  static const PRODUCT_ID = 'productId';
  static const USER_ID = 'userId';
  static const DESCRIPTION = 'description';
  static const AMOUNT = 'amount';
  static const STATUS = 'status';
  static const CREATED_AT = 'createdAt';

  String _id;
  String _productId;
  String _userId;
  String _description;
  double _amount;
  String _status;
  String _createdAt;

  String get id => _id;
  String get productId => _productId;
  String get userId => _userId;
  String get description => _description;
  double get amount => _amount;
  String get status => _status;
  String get createdAt => _createdAt;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.get(ID);
    _productId = snapshot.get(PRODUCT_ID);
    _userId = snapshot.get(USER_ID);
    _description = snapshot.get(DESCRIPTION);
    _amount = snapshot.get(AMOUNT);
    _status = snapshot.get(STATUS);
    _createdAt = snapshot.get(CREATED_AT);
  }
}

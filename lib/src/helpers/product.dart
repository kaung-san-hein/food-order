import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order/src/models/product.dart';

class ProductServices {
  CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> _productsList = [];
    return await _products.get().then((snapshot) {
      for (DocumentSnapshot product in snapshot.docs) {
        _productsList.add(ProductModel.fromSnapshot(product));
      }
      return _productsList;
    });
  }

  Future<List<ProductModel>> getProductsByCategoryId(
      {String categoryId}) async {
    List<ProductModel> _productsList = [];
    return await _products
        .where("categoryId", isEqualTo: categoryId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot product in snapshot.docs) {
        _productsList.add(ProductModel.fromSnapshot(product));
      }
      return _productsList;
    });
  }

  Future<List<ProductModel>> getProductsByRestaurantId(
      {String restaurantId}) async {
    List<ProductModel> _productsList = [];
    return await _products
        .where("restaurantId", isEqualTo: restaurantId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot product in snapshot.docs) {
        _productsList.add(ProductModel.fromSnapshot(product));
      }
      return _productsList;
    });
  }

  Future<List<ProductModel>> searchProducts({String name}) async {
    String searchKey = name[0].toLowerCase() + name.substring(1);
    List<ProductModel> _productsList = [];
    return await _products
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((snapshot) {
          for (DocumentSnapshot product in snapshot.docs) {
            _productsList.add(ProductModel.fromSnapshot(product));
          }
          return _productsList;
        });
  }
}

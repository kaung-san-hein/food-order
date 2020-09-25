import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order/src/models/category.dart';

class CategoryServices {
  CollectionReference _categories =
      FirebaseFirestore.instance.collection('categories');

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> _categoriesList = [];
    return await _categories.get().then((snapshot) {
      for (DocumentSnapshot category in snapshot.docs) {
        _categoriesList.add(CategoryModel.fromSnapshot(category));
      }
      return _categoriesList;
    });
  }
}

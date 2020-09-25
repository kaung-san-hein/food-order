import 'package:flutter/foundation.dart';
import 'package:food_order/src/helpers/category.dart';
import 'package:food_order/src/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> _categoriesList = [];

  List<CategoryModel> get categoriesList => _categoriesList;

  CategoryProvider.initialize() {
    _loadCategories();
  }

  _loadCategories() async {
    _categoriesList = await _categoryServices.getCategories();
    notifyListeners();
  }
}

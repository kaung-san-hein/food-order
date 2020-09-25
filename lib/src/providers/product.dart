import 'package:flutter/foundation.dart';
import 'package:food_order/src/helpers/product.dart';
import 'package:food_order/src/models/product.dart';

class ProductProvider extends ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> _productsList = [];
  List<ProductModel> _productsByCategory = [];
  List<ProductModel> _productsByRestaurant = [];
  List<ProductModel> _productSearch = [];

  List<ProductModel> get productsList => _productsList;
  List<ProductModel> get productsByCategory => _productsByCategory;
  List<ProductModel> get productsByRestaurant => _productsByRestaurant;
  List<ProductModel> get productSearch => _productSearch;

  ProductProvider.initialize() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    _productsList = await _productServices.getProducts();
    notifyListeners();
  }

  Future<void> loadProductsByCategory({String categoryId}) async {
    _productsByCategory =
        await _productServices.getProductsByCategoryId(categoryId: categoryId);
    notifyListeners();
  }

  Future<void> loadProductsByRestaurant({String restaurantId}) async {
    _productsByRestaurant = await _productServices.getProductsByRestaurantId(
        restaurantId: restaurantId);
    notifyListeners();
  }

  Future<void> search({String name}) async {
    _productSearch = await _productServices.searchProducts(name: name);
    notifyListeners();
  }
}

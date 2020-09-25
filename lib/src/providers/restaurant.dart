import 'package:flutter/foundation.dart';
import 'package:food_order/src/helpers/restaurant.dart';
import 'package:food_order/src/models/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> _restaurantsList = [];
  List<RestaurantModel> _restaurantSearch = [];
  RestaurantModel _restaurantModel;

  List<RestaurantModel> get restaurantsList => _restaurantsList;
  RestaurantModel get restaurantModel => _restaurantModel;
  List<RestaurantModel> get restaurantSearch => _restaurantSearch;

  RestaurantProvider.initialize() {
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    _restaurantsList = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  Future<void> loadSignalRestaurant({String id}) async {
    _restaurantModel = await _restaurantServices.getRestaurantById(id: id);
    notifyListeners();
  }

  Future<void> search({String name}) async {
    _restaurantSearch = await _restaurantServices.searchRestaurants(name: name);
    notifyListeners();
  }
}

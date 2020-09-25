import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order/src/models/restaurant.dart';

class RestaurantServices {
  CollectionReference _restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  Future<List<RestaurantModel>> getRestaurants() async {
    List<RestaurantModel> _restaurantsList = [];
    return await _restaurants.get().then((snapshot) {
      for (DocumentSnapshot restaurant in snapshot.docs) {
        _restaurantsList.add(RestaurantModel.fromSnapshot(restaurant));
      }
      return _restaurantsList;
    });
  }

  Future<RestaurantModel> getRestaurantById({String id}) async {
    return await _restaurants
        .doc(id)
        .get()
        .then((snapshot) => RestaurantModel.fromSnapshot(snapshot));
  }

  Future<List<RestaurantModel>> searchRestaurants({String name}) async {
    String searchKey = name[0].toLowerCase() + name.substring(1);
    List<RestaurantModel> _restaurantsList = [];
    return await _restaurants
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((snapshot) {
          for (DocumentSnapshot restaurant in snapshot.docs) {
            _restaurantsList.add(RestaurantModel.fromSnapshot(restaurant));
          }
          return _restaurantsList;
        });
  }
}

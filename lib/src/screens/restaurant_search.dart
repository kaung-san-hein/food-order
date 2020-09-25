import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/models/restaurant.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/providers/restaurant.dart';
import 'package:food_order/src/screens/restaurant.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:food_order/src/widgets/restaurants.dart';
import 'package:provider/provider.dart';
import 'bag.dart';

class RestaurantSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Restaurants",
          color: white,
          size: 18,
        ),
        iconTheme: IconThemeData(color: white),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, ShoppingBag());
                },
              ),
              Positioned(
                right: 7.0,
                top: 8.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: grey[400],
                        offset: Offset(2, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: CustomText(
                      text: "2",
                      color: red,
                      size: 8.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Selector<RestaurantProvider, List<RestaurantModel>>(
          selector: (BuildContext context, restaurantProvider) =>
              restaurantProvider.restaurantSearch,
          builder: (BuildContext context, restaurantSearch, child) {
            if (restaurantSearch.length < 1) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: grey,
                      size: 30,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomText(
                      text: "No Restaurants Found",
                      size: 22,
                      color: grey,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: restaurantSearch.length,
              itemBuilder: (BuildContext context, index) {
                final restaurant = restaurantSearch[index];
                return GestureDetector(
                  onTap: () async {
                    await context
                        .read<ProductProvider>()
                        .loadProductsByRestaurant(restaurantId: restaurant.id);
                    changeScreen(
                      context,
                      RestaurantScreen(
                        restaurantModel: restaurant,
                      ),
                    );
                  },
                  child: RestaurantWidget(restaurant: restaurant),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/models/restaurant.dart';
import 'package:food_order/src/models/user.dart';
import 'package:food_order/src/providers/app.dart';
import 'package:food_order/src/providers/auth.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/providers/restaurant.dart';
import 'package:food_order/src/screens/login.dart';
import 'package:food_order/src/screens/product_search.dart';
import 'package:food_order/src/screens/restaurant.dart';
import 'package:food_order/src/screens/restaurant_search.dart';
import 'package:food_order/src/widgets/loading.dart';
import 'package:food_order/src/widgets/restaurants.dart';
import 'package:food_order/src/widgets/small_floating_button.dart';
import 'package:transparent_image/transparent_image.dart';
import 'bag.dart';
import 'package:food_order/src/widgets/categories.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:food_order/src/widgets/featured_products.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        title: CustomText(
          text: "Food Order",
          color: white,
          size: 18,
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
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () async {
                  if (await context.read<AuthProvider>().signOut()) {
                    changeScreenReplacement(context, Login());
                  }
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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Selector<AuthProvider, UserModel>(
                selector: (context, authProvider) => authProvider.userModel,
                builder: (context, userModel, child) {
                  return CustomText(
                    text: userModel.name,
                    size: 18.0,
                    color: white,
                    weight: FontWeight.bold,
                  );
                },
              ),
              accountEmail: Selector<AuthProvider, UserModel>(
                selector: (context, authProvider) => authProvider.userModel,
                builder: (context, userModel, child) {
                  return CustomText(
                    text: userModel.email,
                    color: grey[700],
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: CustomText(text: "Account"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: Selector<AppProvider, bool>(
        selector: (BuildContext context, appProvider) => appProvider.isLoading,
        builder: (BuildContext context, isLoading, child) {
          if (isLoading) {
            return Loading();
          }
          return SafeArea(
            child: ListView(
              children: [
                // search box
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: grey[400],
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: red,
                      ),
                      title: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (pattern) async {
                          context.read<AppProvider>().changeLoading();
                          if (context.read<AppProvider>().searchBy ==
                              SearchBy.PRODUCTS) {
                            await context
                                .read<ProductProvider>()
                                .search(name: pattern);
                            changeScreen(context, ProductSearchScreen());
                          } else {
                            await context
                                .read<RestaurantProvider>()
                                .search(name: pattern);
                            changeScreen(context, RestaurantSearchScreen());
                          }

                          context.read<AppProvider>().changeLoading();
                        },
                        decoration: InputDecoration(
                          hintText: "Find foods or restaurants",
                          border: InputBorder.none,
                        ),
                      ),
                      trailing: DropdownButton<String>(
                        icon: Icon(
                          Icons.filter_list,
                          color: primary,
                        ),
                        elevation: 0,
                        items: <String>["Products", "Restaurants"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == "Products") {
                            context
                                .read<AppProvider>()
                                .changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          } else {
                            context.read<AppProvider>().changeSearchBy(
                                newSearchBy: SearchBy.RESTAURANTS);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                // categories
                Categories(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: "Products",
                    size: 20.0,
                    color: grey,
                  ),
                ),
                Featured(),

                // popular restaurants
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: "Popular Restaurants",
                    size: 20.0,
                    color: grey,
                  ),
                ),
                Selector<RestaurantProvider, List<RestaurantModel>>(
                  selector: (BuildContext context, restaurantProvider) =>
                      restaurantProvider.restaurantsList,
                  builder: (BuildContext context, restaurantsList, child) {
                    return Column(
                      children: restaurantsList.map((restaurant) {
                        return GestureDetector(
                          onTap: () async {
                            await context
                                .read<ProductProvider>()
                                .loadProductsByRestaurant(
                                    restaurantId: restaurant.id);
                            changeScreen(
                              context,
                              RestaurantScreen(
                                restaurantModel: restaurant,
                              ),
                            );
                          },
                          child: RestaurantWidget(restaurant: restaurant),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

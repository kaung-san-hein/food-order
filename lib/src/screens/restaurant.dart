import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/models/restaurant.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/screens/details.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:food_order/src/widgets/loading.dart';
import 'package:food_order/src/widgets/product.dart';
import 'package:food_order/src/widgets/small_floating_button.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class RestaurantScreen extends StatelessWidget {
  final RestaurantModel restaurantModel;

  RestaurantScreen({this.restaurantModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Loading(),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: restaurantModel.image,
                    height: 160,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 60,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomText(
                      text: restaurantModel.name,
                      color: white,
                      size: 26,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 40,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomText(
                      text: "Average Price: \$" +
                          restaurantModel.avgPrice.toString(),
                      color: white,
                      size: 18,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text(restaurantModel.rating.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: black.withOpacity(0.2)),
                            child: Icon(
                              Icons.close,
                              color: white,
                            )),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {},
                        child: SmallButton(Icons.favorite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomText(
                  text: "Open",
                  color: green,
                  weight: FontWeight.w400,
                  size: 18,
                ),
                Container(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.restaurant_menu),
                    label: CustomText(text: "Book Now"),
                  ),
                ),
              ],
            ),
            Column(
              children: context
                  .watch<ProductProvider>()
                  .productsByRestaurant
                  .map((product) {
                return GestureDetector(
                  onTap: () => changeScreen(context, Details(product: product)),
                  child: ProductWidget(productModel: product),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

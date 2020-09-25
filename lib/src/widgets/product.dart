import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/models/product.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/providers/restaurant.dart';
import 'package:food_order/src/screens/restaurant.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;

  ProductWidget({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 10),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset(-2, -1), blurRadius: 5),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 140,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image.network(
                  productModel.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(text: productModel.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(1, 1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.favorite_border,
                              color: red,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Row(
                      children: [
                        CustomText(
                          text: "from: ",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await context
                                .read<ProductProvider>()
                                .loadProductsByRestaurant(
                                    restaurantId: productModel.restaurantId);
                            await context
                                .read<RestaurantProvider>()
                                .loadSignalRestaurant(
                                    id: productModel.restaurantId);
                            changeScreen(
                              context,
                              RestaurantScreen(
                                restaurantModel: context
                                    .read<RestaurantProvider>()
                                    .restaurantModel,
                              ),
                            );
                          },
                          child: CustomText(
                            text: productModel.restaurant,
                            color: primary,
                            weight: FontWeight.w300,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CustomText(
                              text: productModel.rating.toString(),
                              color: grey,
                              size: 14.0,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.star,
                            color: red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: red,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: grey,
                            size: 16,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                          text: "\$${productModel.price}",
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

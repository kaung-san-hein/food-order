import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/models/product.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../helpers/style.dart';
import 'custom_text.dart';
import 'loading.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Selector<ProductProvider, List<ProductModel>>(
        selector: (BuildContext context, productProvider) =>
            productProvider.productsList,
        builder: (BuildContext context, productsList, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productsList.length,
            itemBuilder: (BuildContext context, int index) {
              final product = productsList[index];

              return GestureDetector(
                onTap: () {
                  changeScreen(
                    context,
                    Details(product: product),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 240,
                    width: 200,
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: red[50],
                          offset: Offset(15, 5),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Loading(),
                              ),
                            ),
                            Center(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: "${product.image}",
                                width: 140,
                                height: 140,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomText(
                                text: product.name,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey[300],
                                      offset: Offset(1, 1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: true
                                      ? Icon(
                                          Icons.favorite,
                                          color: red,
                                          size: 18,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: red,
                                          size: 18,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CustomText(
                                      text: product.rating.toString(),
                                      color: grey,
                                      size: 14),
                                ),
                                SizedBox(width: 2),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: red, size: 16),
                                Icon(Icons.star, color: grey, size: 16),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CustomText(
                                text: "\$${product.price}",
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

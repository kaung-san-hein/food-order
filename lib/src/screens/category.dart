import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/models/category.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/screens/details.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:food_order/src/widgets/loading.dart';
import 'package:food_order/src/widgets/product.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel categoryModel;

  CategoryScreen({this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
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
                    image: categoryModel.image,
                    height: 160,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Container(
                  height: 160,
                  decoration: BoxDecoration(
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
                  bottom: 40,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomText(
                      text: categoryModel.name,
                      size: 26,
                      color: white,
                      weight: FontWeight.w300,
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: black.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.close,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: context
                  .watch<ProductProvider>()
                  .productsByCategory
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

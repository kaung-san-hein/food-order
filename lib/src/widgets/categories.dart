import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/models/category.dart';
import 'package:food_order/src/providers/category.dart';
import 'package:food_order/src/providers/product.dart';
import 'package:food_order/src/screens/category.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../helpers/style.dart';
import 'custom_text.dart';
import 'loading.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: Selector<CategoryProvider, List<CategoryModel>>(
        selector: (BuildContext context, categoryProvider) =>
            categoryProvider.categoriesList,
        builder: (BuildContext context, categoriesList, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoriesList.length,
            itemBuilder: (BuildContext context, int index) {
              final category = categoriesList[index];

              return GestureDetector(
                onTap: () async {
                  await context
                      .read<ProductProvider>()
                      .loadProductsByCategory(categoryId: category.id);
                  changeScreen(
                      context,
                      CategoryScreen(
                        categoryModel: category,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: red[50],
                              offset: Offset(4, 6),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
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
                                  image: "${category.image}",
                                  width: 60,
                                  height: MediaQuery.of(context).size.width / 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      CustomText(
                        text: "${category.name}",
                        size: 15.0,
                        color: grey[900],
                      ),
                    ],
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

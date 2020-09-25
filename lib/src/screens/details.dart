import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/screen_navigation.dart';
import 'package:food_order/src/models/product.dart';
import 'package:food_order/src/widgets/custom_text.dart';
import 'package:food_order/src/widgets/loading.dart';
import '../helpers/style.dart';
import 'bag.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300.0,
              child: Stack(
                children: [
                  Carousel(
                    images: [
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            ),
                          ),
                          Center(
                            child: Image.network("${widget.product.image}"),
                          ),
                        ],
                      ),
                      Image.network("${widget.product.image}"),
                      Image.network("${widget.product.image}"),
                    ],
                    autoplay: false,
                    dotBgColor: white,
                    dotIncreasedColor: red,
                    dotColor: grey,
                    dotIncreaseSize: 1.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Stack(
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
                                  color: red,
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
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  child: CustomText(
                                    text: "2",
                                    color: white,
                                    size: 8.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 55.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: grey[400],
                            offset: Offset(2, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.favorite,
                          size: 22,
                          color: red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomText(
              text: widget.product.name,
              size: 26.0,
              weight: FontWeight.bold,
            ),
            CustomText(
              text: "\$" + widget.product.price.toString(),
              size: 20.0,
              color: red,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.remove, size: 36),
                    onPressed: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: red,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                    child: CustomText(
                      text: "Add To Bag",
                      size: 26,
                      color: white,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.add, size: 36, color: red),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_order/src/helpers/style.dart';
import 'package:food_order/src/widgets/custom_text.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Shopping Bag",
          color: white,
          size: 18,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              Positioned(
                right: 7.0,
                bottom: 8.0,
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
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: white,
      body: ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Container(
          //     height: 120.0,
          //     decoration: BoxDecoration(
          //       color: white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: red[100],
          //           offset: Offset(3, 5),
          //           blurRadius: 30,
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           "images/${product.image}",
          //           height: 120,
          //           width: 120,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             RichText(
          //               text: TextSpan(
          //                 children: [
          //                   TextSpan(
          //                     text: product.name + "\n",
          //                     style: TextStyle(color: black, fontSize: 20.0),
          //                   ),
          //                   TextSpan(
          //                     text: "\$" + product.price.toString(),
          //                     style: TextStyle(color: black, fontSize: 17.0),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               width: 120,
          //             ),
          //             IconButton(
          //               icon: Icon(
          //                 Icons.delete,
          //                 color: red,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

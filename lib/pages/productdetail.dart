import 'package:dob/data/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({this.product});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: Colors.transparent),
          ),
          Hero(
            tag: product.description, // this needs to be changed
            child: Image(
              height: height * 0.32,
              width: MediaQuery.of(context).size.width,
              image: FileImage(product.image),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: height * 0.30,
          //   child: Container(
          //     height: height * 0.75,
          //     width: width,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(30.0),
          //           topRight: Radius.circular(30.0)),
          //       color: Colors.white,
          //     ),
          //     child: Column(
          //       children: <Widget>[
          //         Text(
          //           product.title,
          //           style: TextStyle(
          //               fontSize: 24.0,
          //               fontWeight: FontWeight.w400,
          //               letterSpacing: 1.2),
          //         ),
          //         SizedBox(height: 30),
          //         Text(
          //           product.description,
          //           style: TextStyle(
          //               fontSize: 24.0,
          //               fontWeight: FontWeight.w400,
          //               letterSpacing: 1.2),
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

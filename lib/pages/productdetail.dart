import 'package:dob/data/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail({this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // this needs to be changed

          Image(
            height: 300,
            width: width,
            image: FileImage(widget.product.image),
            fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}

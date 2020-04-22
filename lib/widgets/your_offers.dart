import 'package:dob/data/model/product_model.dart';
import 'package:dob/pages/productdetail.dart';
import 'package:dob/widgets/navigationeffects.dart';
import 'package:flutter/material.dart';

class YourOffers extends StatefulWidget {
  final Product product;
  YourOffers(this.product);
  @override
  _YourOffersState createState() => _YourOffersState();
}

class _YourOffersState extends State<YourOffers> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          ScaleRoute(
              page: ProductDetail(
            product: widget.product,
          )),
        )
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[200],
          ),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              //this needs to be changed
              child: Image(
                image: FileImage(widget.product.image),
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.product.description,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '${widget.product.days} days ${widget.product.hours} hours Remaining',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



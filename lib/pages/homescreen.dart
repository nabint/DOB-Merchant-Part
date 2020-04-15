import 'package:dob/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:dob/pages/createnewoffer.dart';
import 'package:dob/pages/profiledetail.dart';
import 'package:dob/scoped-models/products.dart';
import 'package:dob/widgets/your_offers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  final String userEmail;

  HomeScreen({@required this.userEmail});
  @override
  Widget build(BuildContext context) {
    Widget _buildNewOffer() {
      return Center(
        child: FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateNewOffer())),
          child: Text(
            'Add New Offer',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      );
    }

    // TODO: implement build
    return ScopedModelDescendant<Products>(
        builder: (BuildContext context, Widget child, Products model) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            iconSize: 30.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetail(),
                ),
              );
            },
          ),
          title: Center(
              child: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          )),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                print("Inside Home Logging Oout");
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewOffer(),
            ),
          ),
          label: Text("Add New Offer"),
          icon: Icon(Icons.add),
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Your Offers",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2),
              ),
            ),
            // _buildProductList(model.allProducts),
            if (model.allProducts.length > 0)
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) =>
                    YourOffers(model.allProducts[index]),
                itemCount: model.allProducts.length,
              )
            else
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      SvgPicture.asset(
                        'assets/images/shopping.svg',
                        placeholderBuilder: (context) =>
                            CircularProgressIndicator(),
                        color: Color(0xff686868),
                        height: 128.0,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Center(
                          child: Text(
                        "No Offers \nAdded",
                        style: TextStyle(
                            color: Color(0xff686868),
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  )),

            //_buildNewOffer(),
          ],
        ),
      );
    });
  }

  /*Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              YourOffers(products[index]),
          itemCount: products.length,
        ),
      );
    } else {
      productCards = Container(
        child: Text('null'),
      );
    }
    return productCards;
  }
  _buildProductList() {
    List<Widget> productList = [];
    allProducts.forEach(
      (Product product) {
        productList.add(YourOffers(product));
      },
    );
    return productList;
  }*/
}

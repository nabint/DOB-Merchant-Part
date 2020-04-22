import 'package:dob/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:dob/pages/createnewoffer.dart';
import 'package:dob/pages/profiledetail.dart';
import 'package:dob/scoped-models/products.dart';
import 'package:dob/widgets/navigationeffects.dart';
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
          onPressed: () => Navigator.push(
              context, SlideUpwardsRoute(page: CreateNewOffer())),
          child: Text(
            'Add New Offer',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      );
    }

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
                SlideRightRoute(
                  page: ProfileDetail(),
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
            SlideUpwardsRoute(
              page: CreateNewOffer(),
            ),
          ),
          label: Text("Add New Offer"),
          icon: Icon(Icons.add),
        ),
        body: ListView(
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
                      Container(
                        padding: EdgeInsets.only(right:30.0),
                        //decoration: BoxDecoration(border:Border.all(width:1.0),borderRadius:BorderRadius.circular(20.0)),
                        child: SvgPicture.asset(
                            'assets/images/shopping.svg',
                            placeholderBuilder: (context) =>
                                CircularProgressIndicator(),
                            color: Color(0xff686868),
                            height: 128.0,
                          ),
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
          ],
        ),
      );
    });
  }
}

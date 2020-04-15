import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffA1013D), Color(0xff550120)]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    " BigByte",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Computer Store | KamalPokhari "),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 50.0,
                    child: null,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: CachedNetworkImageProvider(
                      'https://www.alrasub.com/wp-content/uploads/2012/07/cursebat.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

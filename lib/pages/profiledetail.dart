import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            
            Container(
              height: 320.0,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //       colors: [Color(0xffA1013D), Color(0xff550120)]),
              // ),
              child: CachedNetworkImage(
                imageUrl:
                    "https://cdn.vox-cdn.com/thumbor/88ZNXzJh_vj7sfW4LJxGpBTS5zo=/0x0:1100x619/1200x800/filters:focal(538x10:714x186)/cdn.vox-cdn.com/uploads/chorus_image/image/56068669/google_exterior.0.0.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                iconSize: 30.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            
            Column(
              children: <Widget>[
                
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: _buildHeader(context),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: _buildUserDetails())
              ],
            ),
          ],
        ),
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
                top: 40.0, left: 10.0, right: 10.0, bottom: 10.0),
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
                    " BigByte Pvt Lmtd",
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

  Widget _buildUserDetails() {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Store's information"),
            ),
            Divider(),
            ListTile(
              title: Text("Email"),
              subtitle: Text("google@gmail.com"),
              leading: Icon(Icons.email),
            ),
            ListTile(
              title: Text("Phone"),
              subtitle: Text("+977-9815225566"),
              leading: Icon(Icons.phone),
            ),
            ListTile(
              title: Text("Website"),
              subtitle: Text("https://www.google.com"),
              leading: Icon(Icons.web),
            ),
            ListTile(
              title: Text("About"),
              subtitle: Text(
                  "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text("Joined Date"),
              subtitle: Text("15 February 2020"),
              leading: Icon(Icons.calendar_view_day),
            ),
          ],
        ),
      ),
    );
  }
}

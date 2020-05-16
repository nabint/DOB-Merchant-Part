import 'package:dob/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:dob/bloc/register_bloc/register_bloc.dart';
import 'package:dob/bloc/register_bloc/register_event.dart';
import 'package:dob/bloc/register_bloc/register_state.dart';
import 'package:dob/pages/homescreen.dart';
import 'package:dob/pages/register/registerbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

GoogleMapsPlaces _places =
    GoogleMapsPlaces(apiKey: "AIzaSyAHbxSS8nMi8aJb5kEUEW8Xvn654abk1gc");

class OutletScreen extends StatefulWidget {
  final String email, password, phoneNum;
  OutletScreen({this.email, this.password, this.phoneNum});
  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  LatLng _finalPosition = _initialPosition;
  LatLng userPosition;
  final List<String> merchant_outlet = [];
  String storeloc = "Enter your Store's location here";
  GoogleMapController mapController;
  static LatLng _initialPosition;
  TextEditingController targetController = TextEditingController();
  RegisterBloc _registerBloc;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);

    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      userPosition = _initialPosition;
    });
  }

  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Skip",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            new Expanded(
              child: new Text(""),
            ),
          ],
        ),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registering...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userEmail: widget.email)),
            );
          }
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Registration Failure'),
                      Icon(Icons.error),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  "Just One more Step and you're done",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "List out all your Outlets",
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(height: 20),
            if (_initialPosition == null)
              Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 500),
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17.0),
                      myLocationEnabled: true,
                      compassEnabled: true,
                      markers: _markers,
                      onCameraMove: _onCameraMove,
                      onMapCreated: onCreated,
                    ),
                    Positioned(
                      top: 5.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Icon(Icons.store),
                            SizedBox(
                              width: 20.0,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 250),
                              child: GestureDetector(
                                onTap: () async {
                                  Prediction p = await PlacesAutocomplete.show(
                                      context: context,
                                      apiKey:
                                          "AIzaSyAHbxSS8nMi8aJb5kEUEW8Xvn654abk1gc",
                                      mode: Mode.overlay);
                                  setState(() {
                                    targetController.text = p.description;
                                    storeloc = targetController.text;
                                    sendRequest(storeloc);
                                    print(targetController.text);
                                    merchant_outlet.add(storeloc);
                                    print(merchant_outlet);
                                    print(merchant_outlet.length);
                                  });
                                },
                                child: Text(
                                  storeloc,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 30),
            Center(
                child: RegisterButton(
              buttonText: 'Sign Up',
              onPressed: _onFormSubmitted,
            )),
          ],
        ),
      ),
    );
  }

  void _addMarker(LatLng location, String address) {
    setState(() {
      print(" Marker is called");
      userPosition = location;
      _markers.add(
        Marker(
            markerId: MarkerId(_finalPosition.toString()),
            position: location,
            infoWindow: InfoWindow(title: address, snippet: "Go Here"),
            icon: BitmapDescriptor.defaultMarker),
      );
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: userPosition, zoom: 17),
        ),
      );
    });
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _finalPosition = position.target;
    });
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: widget.email,
        password: widget.password,
        address: null,
        name: null,
      ),
    );
  }
}

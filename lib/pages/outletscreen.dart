import 'package:dob/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:dob/bloc/register_bloc/register_bloc.dart';
import 'package:dob/bloc/register_bloc/register_event.dart';
import 'package:dob/bloc/register_bloc/register_state.dart';
import 'package:dob/pages/homescreen.dart';
import 'package:dob/pages/register/registerbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutletScreen extends StatefulWidget {
  final String email, password, phoneNum;
  OutletScreen({this.email, this.password, this.phoneNum});
  @override
  _OutletScreenState createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  RegisterBloc _registerBloc;
  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
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
            // FlatButton.icon(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => OutletScreen()),
            //     );
            //   },
            //   icon: Icon(Icons.arrow_forward_ios),
            //   label: Text("Skip"),
            //   ),
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
            Navigator.push(
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
        child: Center(
            child: RegisterButton(
          buttonText: 'Sign Up',
          onPressed: _onFormSubmitted,
        )),
      ),
    );
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

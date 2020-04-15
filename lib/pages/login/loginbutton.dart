import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // return RaisedButton(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(30.0),
    //   ),
    //   onPressed: _onPressed,
    //   child: Text('Login'),
    // );
    return _buildLoginButton();
  }

  Widget _buildLoginButton() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
            color: Color(0xff6E012A), borderRadius: BorderRadius.circular(20)),
        child: FlatButton(
          onPressed: _onPressed,
          child: Text(
            "Log In",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

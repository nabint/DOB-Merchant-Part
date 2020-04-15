import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //   return RaisedButton(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(30.0),
    //     ),
    //     onPressed: _onPressed,
    //     child: Text('Register'),
    //   );
    return _buildregisterButton();
  }

  Widget _buildregisterButton() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 270,
        height: 50,
        decoration: BoxDecoration(
            color: Color(0xff6E012A), borderRadius: BorderRadius.circular(20)),
        child: FlatButton(
          onPressed: _onPressed,
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.white,fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}

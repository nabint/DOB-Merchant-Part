import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final String _buttonText;
  RegisterButton({Key key, VoidCallback onPressed, String buttonText})
      : _onPressed = onPressed,
        _buttonText = buttonText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildregisterButton();
  }

  Widget _buildregisterButton() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: (){},
        child: Container(
          width: 270,
          height: 50,
          decoration: BoxDecoration(
              color: Color(0xff6E012A),
              borderRadius: BorderRadius.circular(20)),
          child: FlatButton(
            onPressed: _onPressed,
            child: Text(
              _buttonText,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}

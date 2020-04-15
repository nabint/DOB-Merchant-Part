import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/register/registerscreen.dart';
import 'package:flutter/material.dart';


class CreateAccountButton extends StatelessWidget {
  final AuthRepository _authRepository;

  CreateAccountButton({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(authRepository: _authRepository);
          }),
        );
      },
    );
  }
}



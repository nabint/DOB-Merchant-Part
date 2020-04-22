import 'package:dob/bloc/login_bloc/login_bloc.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/login/loginform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  LoginScreen({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authRepository: _authRepository),
        child: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: LoginForm(authRepository: _authRepository),
        ),
      ),
    );
  }
}

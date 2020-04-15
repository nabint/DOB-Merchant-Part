import 'package:dob/bloc/register_bloc/register_bloc.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/register/registerform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final AuthRepository _authRepository;

  RegisterScreen({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Text(
        'Register',
        style: TextStyle(color: Colors.black),
      )),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: _authRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

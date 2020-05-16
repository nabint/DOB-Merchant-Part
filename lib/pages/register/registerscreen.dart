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
      backgroundColor: Colors.white,
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: _authRepository),
          child: Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: RegisterForm(_authRepository),
          ),
        ),
      ),
    );
  }
}

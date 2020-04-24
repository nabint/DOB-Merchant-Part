import 'package:dob/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:dob/bloc/register_bloc/register_bloc.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/widgets/phone_auth_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../bloc/register_bloc/register_event.dart';
import 'package:dob/bloc/register_bloc/register_state.dart';
import 'package:dob/pages/register/registerbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  final AuthRepository _authRepository;
  RegisterForm(this._authRepository);
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String name, url, address, phoneNum;
  RegisterBloc _registerBloc;
  bool _isloading = false;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : BlocListener<RegisterBloc, RegisterState>(
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
                Navigator.of(context).pop();
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
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          autovalidate: true,
                          validator: (_) {
                            return !state.isEmailValid ? 'Invalid Email' : null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          autocorrect: false,
                          autovalidate: true,
                          validator: (_) {
                            return !state.isPasswordValid
                                ? 'Invalid Password'
                                : null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Confirm Password ',
                          ),
                          obscureText: true,
                          autocorrect: false,
                          autovalidate: true,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            if (val != _passwordController.text)
                              return 'Not Match';
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: 'Phone',
                            hintText: '+977-',
                          ),
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          autovalidate: true,
                          onChanged: (value) {
                            setState(() {
                              phoneNum = '+977' +
                                  _phoneController.text.toString().trim();
                            });
                          },
                        ),
                        SizedBox(height: 30.0),
                        RegisterButton(
                          buttonText: 'Verify Your Phone Number',
                          // onPressed: isRegisterButtonEnabled(state)
                          //     ? _onFormSubmitted
                          //     : null,
                          onPressed: () async {
                            phonelogin(
                                _emailController.text,
                                _passwordController.text,
                                _phoneController.text.toString(),
                                widget._authRepository);
                                
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  void phonelogin(String email, String password, String phonenum,AuthRepository authRepository) async {
    // setState(() {
    //   _isloading = true;
    //   print('True');
    // });
    await PhoneAuthScreen(email: email,password: password,phoneNum: phonenum,authRepository:authRepository).loginUser(phoneNum, context);

//     Future.delayed(const Duration(seconds: 4), () {
//       setState(() {
//         _isloading = false;
//         print('False');
//       });
//     });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        name: name,
        address: address,
        url: url,
      ),
    );
  }
}

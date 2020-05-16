import 'package:dob/bloc/register_bloc/register_bloc.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/signupdetails.dart';
import 'package:dob/widgets/phone_auth_field.dart';
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
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();

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
            listener: (context, state) {},
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return Form(
                  autovalidate: _autoValidate,
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "User Sign Up",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          autovalidate: false,
                          validator: (_) {
                            return !state.isEmailValid ? 'Invalid Email' : null;
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: 'Password',
                              helperText:
                                  "Should be over 8 character and contain number"),
                          obscureText: true,
                          autocorrect: false,
                          autovalidate: false,
                          validator: (_) {
                            return !state.isPasswordValid
                                ? 'Invalid Password'
                                : null;
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Confirm Password ',
                          ),
                          obscureText: true,
                          autocorrect: false,
                          autovalidate: false,
                          validator: (val) {
                            if (val.isEmpty) return 'Empty';
                            if (val != _passwordController.text)
                              return 'Passwords Don\'t Match';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: 'Phone',
                            hintText: '+977-',
                          ),
                          controller: _phoneController,
                          keyboardType: TextInputType.number,
                          autocorrect: false,
                          autovalidate: false,
                          onChanged: (value) {
                            setState(() {
                              phoneNum = '+977' +
                                  _phoneController.text.toString().trim();
                            });
                          },
                          validator: (value) {
                            if (value.length != 10) {
                              return 'Please Enter Valid PhoneNumber';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Align(
                        child: Container(
                          width: 270,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5, color: Color(0xff6E012A)),
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            onPressed: () {
                              // if (_formKey.currentState.validate()) {
                              //   phonelogin(
                              //       _emailController.text,
                              //       _passwordController.text,
                              //       _phoneController.text.toString(),
                              //       widget._authRepository);
                              // }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpDetails(
                                          authRepository:
                                              widget._authRepository,
                                        )),
                              );
                            },
                            child: Text(
                              'Verify Your Phone Number',
                              style: TextStyle(
                                  color: Color(0xff6E012A), fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }

  void phonelogin(String email, String password, String phonenum,
      AuthRepository authRepository) async {
    setState(() {
      _isloading = true;
      print('True');
    });
    await PhoneAuthScreen(
            email: email,
            password: password,
            phoneNum: phonenum,
            authRepository: authRepository)
        .loginUser(phoneNum, context);
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isloading = false;
        print('False');
      });
    });
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
}

import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/register/registerbutton.dart';
import 'package:dob/pages/signupdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends StatefulWidget {
  final String email, password, phoneNo, verificationId;
  final AuthRepository authRepository;
  final int token;

  PhoneVerificationPage(
      {this.email,
      this.password,
      this.phoneNo,
      this.authRepository,
      this.verificationId,
      this.token});

  @override
  _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isloading = false;
  TextEditingController _codeController;
  String verificationCode;

  @override
  void initState() {
    // TODO: implement initState
    TextEditingController _codeController = TextEditingController();
    super.initState();
  }

  void resendVerificationCode(
      String phoneNumber, int forceResendingToken) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 120),
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: (String verificationId, [int forceResendingToken]) {
          print("Code Sent again");
        },
        forceResendingToken: forceResendingToken,
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: Image.asset('assets/images/phone.png'),
                    ),
                    SizedBox(height: 15.0),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 17),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Enter the code sent to \t',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                            ),
                            TextSpan(
                                text: widget.phoneNo,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    PinCodeTextField(
                      length: 6,
                      enableActiveFill: true,
                      obsecureText: false,
                      //controller: _codeController,
                      textInputType: TextInputType.number,
                      backgroundColor: Colors.white95,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          activeColor: Colors.black,
                          activeFillColor: Colors.white95,
                          disabledColor: Colors.white95,
                          inactiveColor: Colors.black,
                          selectedFillColor: Colors.white95,
                          selectedColor: Colors.red,
                          shape: PinCodeFieldShape.underline,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          inactiveFillColor: Colors.white95),
                      animationDuration: Duration(milliseconds: 300),
                      onCompleted: (v) {
                        setState(() {
                          verificationCode = v;
                        });

                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(height: 15),
                    RegisterButton(
                        buttonText: 'Verify',
                        onPressed: () async {
                          print("logging in");
                          setState(() {
                            print("Setting loading to true");
                            _isloading = true;
                          });
                          final code = verificationCode.trim();
                          AuthCredential credential =
                              PhoneAuthProvider.getCredential(
                                  verificationId: widget.verificationId,
                                  smsCode: code);

                          try {
                            AuthResult result =
                                await _auth.signInWithCredential(credential);
                            setState(() {
                              print("Setting loading to false");
                              _isloading = false;
                            });

                            FirebaseUser user = result.user;
                            if (user != null) {
                              
                              
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpDetails(
                                        email: widget.email,
                                        password: widget.password,
                                        phoneNum: widget.phoneNo,
                                        authRepository: widget.authRepository)),
                              );
                            } else {
                             
                            }
                          } catch (err) {
                            print("Error occured");
                            setState(() {
                              print("Setting loading to false");
                              _isloading = false;
                            });
                            Flushbar(
                              borderRadius: 8,
                              message: "Verification Code Not Matched",
                              duration: Duration(seconds: 3),
                            ).show(context);
                          }
                        }),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Didn\'t received the code?\t',
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                        InkWell(
                          child: Container(
                            width: 90,
                            height: 40,
                            child: Center(
                              child: Text(
                                'RESEND',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          onTap: () {
                            print("Resending");
                            resendVerificationCode(
                                widget.phoneNo, widget.token);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

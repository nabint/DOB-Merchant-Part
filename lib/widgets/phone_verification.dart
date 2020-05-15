import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/register/registerbutton.dart';
import 'package:dob/pages/signupdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String email, password, phoneNo, verificationId;
  final AuthRepository authRepository;
  final int token;
  final _codeController = TextEditingController();
  PhoneVerificationPage(
      {this.email,
      this.password,
      this.phoneNo,
      this.authRepository,
      this.verificationId,
      this.token});
  void resendVerificationCode(String phoneNumber, int forceResendingToken) async{
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 120),
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: (String verificationId, [int forceResendingToken]){
          print("Code Sent again");
        },
        forceResendingToken: forceResendingToken,
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                      TextSpan(
                          text: phoneNo,
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
                controller: _codeController,
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
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
              SizedBox(height: 15),
              RegisterButton(
                buttonText: 'Verify',
                onPressed: () async {
                  final code = _codeController.text.trim();
                  AuthCredential credential = PhoneAuthProvider.getCredential(
                      verificationId: verificationId, smsCode: code);

                  AuthResult result =
                      await _auth.signInWithCredential(credential);

                  FirebaseUser user = result.user;

                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpDetails(
                              email: email,
                              password: password,
                              phoneNum: phoneNo,
                              authRepository: authRepository)),
                    );
                  } else {
                    // Scaffold.of(context).showSnackBar(SnackBar)
                  }
                },
              ),
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
                      resendVerificationCode(phoneNo, token);
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

import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/signupdetails.dart';
import 'package:dob/widgets/phone_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final AuthRepository authRepository;
  final String email, password, phoneNum;
  PhoneAuthScreen(
      {this.email, this.password, this.phoneNum, this.authRepository});

  Future<dynamic> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            print("Verified");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SignUpDetails(email:email, password:password, phoneNum:phoneNum,authRepository:authRepository)),
                      //PhoneVerificationPage(phoneNum)),
            );
          } else {
            print("Error");
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
       
        codeSent: (String verificationId, [int forceResendingToken]) {
          
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PhoneVerificationPage(email: email,phoneNo: phone,password: password,authRepository: authRepository,verificationId: verificationId,token:forceResendingToken)),
          );
        },

        codeAutoRetrievalTimeout: null);
  }

  errorDialog(BuildContext context) {
    return AlertDialog(
      title: Text(" Verification error"),
      content: Center(
        child: Text("Not Verified"),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Okay"),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

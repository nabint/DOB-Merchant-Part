import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String userName;
  final String userEmail;
  final String userPassword;
  User({this.userName,this.userEmail,this.userPassword});

  @override
  // TODO: implement props
  List<Object> get props => [userName,userEmail,userPassword];

}
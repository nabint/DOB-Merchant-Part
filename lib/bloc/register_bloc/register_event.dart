import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final String address;
  final String url;

  const Submitted({
    
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.address,
    this.url,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'SubmittedForm { email: $email, password: $password,name:${name},address:${address} }';
  }
}

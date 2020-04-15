part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class Uninitialized extends AuthenticationState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Authenticated extends AuthenticationState{
  final String user;
  const Authenticated({this.user});

  @override
  // TODO: implement props
  List<Object> get props => [user];
}
class UnAuthenticated extends AuthenticationState{
  @override
  // TODO: implement props
  List<Object> get props => null;

}

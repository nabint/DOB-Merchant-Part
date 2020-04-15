part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggedIn extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggedOut extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

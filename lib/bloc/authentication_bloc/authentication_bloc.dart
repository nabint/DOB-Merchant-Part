import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/data/model/User.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  AuthenticationBloc({@required this.authRepository});
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
     else if (event is LoggedIn) {
      print("Authenticated obtained");
    yield Authenticated(user: await authRepository.getUser());
    }
     else if (event is LoggedOut)
    {
      print("Logged Out Event Detected");
      print("Fuck");
      yield UnAuthenticated();
      authRepository.signOut();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    print("App Started function calling");
    try {
      final isSignedIn = await authRepository.isSignedIn();
      if (isSignedIn) {
        final name = await authRepository.getUser();
        yield Authenticated(user: name);
      } else {
        yield UnAuthenticated();
      }
    } catch (_) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    
  }
  
  Stream<AuthenticationState> mapLoggedOut() async* {
    print("Logged Out Function caling");

  }
  
}

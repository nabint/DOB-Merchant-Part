import 'package:dob/color.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/homescreen.dart';
import 'package:dob/pages/login/loginscreen.dart';
import 'package:dob/pages/splashscreen.dart';
import 'package:dob/scoped-models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'bloc/authentication_bloc/simple_bloc_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();//he code is executed before runApp.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final AuthRepository authRepository = AuthRepository();

  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) =>
          AuthenticationBloc(authRepository: authRepository)..add(AppStarted()),
      child: MyApp(
        authRepository: authRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  final Products model = Products();
  MyApp({
    Key key,
    @required AuthRepository authRepository,
  })  : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModel<Products>(
      model: model,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English

        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: createMaterialColor(Color(0xff6E012A)),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is UnAuthenticated) {
              return LoginScreen(authRepository: _authRepository);
            } else if (state is Authenticated) {
              print("Main Authenticated");
              return HomeScreen(
                userEmail: state.user,
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haraka_admin/cubits/cubits.dart';
import './repositories/repositories.dart';
import './screens/screens.dart';
import './blocs/blocs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LoginBloc _loginBloc = LoginBloc(repository: LoginRepository());
  bool auth = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        setState(() {
          auth = false;
        });
      } else {
        setState(() {
          auth = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  Function returnPreferlScreen(Widget s) {
    if (auth) {
      return (context) => s;
    } else {
      return (context) =>
          BlocProvider.value(value: _loginBloc, child: LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': returnPreferlScreen(BlocProvider.value(
          value: DrawerCubit(),
          child: HomeScreen(),
        )),
        '/dashboard': returnPreferlScreen(BlocProvider.value(
          value: DrawerCubit(),
          child: HomeScreen(),
        )),
      },
    );
  }
}

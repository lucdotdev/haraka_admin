import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haraka_admin/cubits/cubits.dart';
import './repositories/repositories.dart';
import './screens/screens.dart';
import './blocs/blocs.dart';

void main() {
  FirebaseAuth.instance.authStateChanges().first;
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
    super.initState();
    if (_auth.currentUser != null) {
      setState(() {
        auth = true;
      });
    }
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
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Function returnPreferlScreen(Widget s) {
      if (auth) {
        return (context) => s;
      } else {
        return (context) =>
            BlocProvider.value(value: _loginBloc, child: LoginScreen());
      }
    }

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
        // '/dashboard': returnPreferlScreen(BlocProvider.value(
        //   value: DrawerCubit(),
        //   child: HomeScreen(),
        // )),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haraka_admin/blocs/blocs.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;

    _login() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        BlocProvider.of<LoginBloc>(context)
            .add(LoginButtonClicked(email: _email, password: _password));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: width - width / 1.5,
          height: heigth * 0.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Connection',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold)),
              BlocConsumer<LoginBloc, LoginState>(
                  cubit: BlocProvider.of<LoginBloc>(context),
                  listener: (context, state) {
                    if (state is LoginSuccefful) {
                      Future.delayed(
                          Duration(milliseconds: 500),
                          () => Navigator.of(context)
                              .pushReplacementNamed('/dashboard'));
                    }
                    if (state is LoginFailed) {
                      showDialogAction(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return CircularProgressIndicator();
                    }
                    return Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width / 3.4,
                              height: width / 17,
                              child: Row(
                                children: [
                                  Text(
                                    'Email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0xffF2F5FF),
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          enabled: true,
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Entrer une Adresse mail';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) => _email = input,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///Password
                            ///
                            ///
                            Container(
                              width: width / 3.4,
                              height: width / 17,
                              child: Row(
                                children: [
                                  Text(
                                    'Mot de passe: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0xffF2F5FF),
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          enabled: true,
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Entrer un mot de passe';
                                          }
                                          return null;
                                        },
                                        onSaved: (input) => _password = input,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///Button
                            ///
                            ///
                            GestureDetector(
                              onTap: () => _login(),
                              child: Container(
                                width: width / 7,
                                height: heigth / 10,
                                child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Color(0xff053C71),
                                    child: Center(
                                        child: Text(
                                      'Continuer',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

Future showDialogAction(context, String msg) async {
  showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text('Erreur', style: TextStyle(color: Colors.red)),
          content: Text(msg, style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            ///NON
            ///
            ///
            ///

            ///OUI
            ///
            ///
            FlatButton(
              child: Text('Reesayer', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

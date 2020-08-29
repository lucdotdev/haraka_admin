import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffF5F6FA),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width),
            child: Center(
              child: Container(
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
              ),
            ),
          ),
        ));
  }
}

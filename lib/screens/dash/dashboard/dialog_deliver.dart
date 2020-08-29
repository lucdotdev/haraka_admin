import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogDeliver extends StatefulWidget {
  DialogDeliver({Key key}) : super(key: key);
  String h = _DialogDeliverState().thatId;

  @override
  _DialogDeliverState createState() => _DialogDeliverState();
}

class _DialogDeliverState extends State<DialogDeliver> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String thatId = "";
  @override
  void initState() {
    super.initState();
    firestore.collection("users").get().then((value) {
      setState(() {
        thatId = value.docs.first.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          // firestore.collection("user").where("a", isEqualTo: 2).get(),
          firestore.collection("users").get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: false,
              itemBuilder: (BuildContext context, i) {
                DocumentSnapshot users = snapshot.data.documents[i];

                return RadioListTile(
                    value: users.id,
                    groupValue: thatId,
                    title: Text(users.data()["name"]),
                    onChanged: (value) {
                      setState(() {
                        thatId = value;
                      });
                    });
              });
        }
        return Text("lol");
      },
    );
  }
}

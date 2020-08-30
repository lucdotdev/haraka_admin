import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogDeliver extends StatefulWidget {
  final String deliveryId;
  DialogDeliver({Key key, @required this.deliveryId}) : super(key: key);

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
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title:
          Text('Selectionner un livreur', style: TextStyle(color: Colors.red)),
      content: Container(
          width: 500,
          height: 500,
          child: FutureBuilder(
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
          )),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok', style: TextStyle(color: Colors.black)),
          onPressed: () {
            firestore.collection("delivery").doc(widget.deliveryId).update(
                {"livreur_id": thatId, "status": 4}).whenComplete(() => null);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

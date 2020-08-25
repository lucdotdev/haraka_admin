import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({Key key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF5F6FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Center(
            child: Container(
              width: width,
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
                children: [
                  Text(
                    "Livarisons :",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("delivery")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 30,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot products =
                                snapshot.data.documents[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(width * 0.04)),
                              child: Container(
                                padding: EdgeInsets.only(left: 30),
                                height: 50,
                                width: width * 0.04,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          blurRadius: 20,
                                          spreadRadius: 3,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Nom  :"),
                                    IconButton(
                                      icon: Icon(
                                        Icons.restore_from_trash,
                                        color: Colors.red,
                                      ),
                                      onPressed: null,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

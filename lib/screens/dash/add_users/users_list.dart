import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haraka_admin/screens/dash/add_users/dialog_add_user.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => addUser(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xffF5F6FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Center(
            child: Container(
              width: width,
              height: width,
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
                    "Utilisateurs :",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 30,
                              child: Center(
                                child: Container(
                                  height: 1,
                                  color: Colors.black38,
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot products =
                                snapshot.data.documents[index];
                            return GestureDetector(
                              onTap: () => null,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(width * 0.04)),
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  height: 50,
                                  width: width * 0.04,
                                  // decoration: BoxDecoration(
                                  //     color: Colors.white54,
                                  //     borderRadius:
                                  //         BorderRadius.all(Radius.circular(20)),
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //           color: Colors.grey[200],
                                  //           blurRadius: 20,
                                  //           spreadRadius: 3,
                                  //           offset: Offset(0, 3))
                                  //     ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Nom  :" +
                                            products.data()['name'].toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      getStatus(products.data()['account_type'],
                                          width)
                                    ],
                                  ),
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

  Widget getStatus(int id, double width) {
    switch (id) {
      case 1:
        return Container(
            width: width / 5,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Text("Bussiness", style: TextStyle(color: Colors.white)),
            ));
        break;
      case 2:
        return Container(
          width: width / 5,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Livreur",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        break;
      default:
        return Text("haaaa");
    }
  }

  Future addUser(context) async {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogAddUser();
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:haraka_admin/screens/dash/dashboard/dialog_deliver.dart';

class DeliveryList extends StatefulWidget {
  const DeliveryList({Key key}) : super(key: key);

  @override
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream fStream;
  String id = '';

  @override
  void initState() {
    super.initState();
    fStream = firestore.collection("delivery").snapshots();
  }

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
                    "Livraisons :",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  StreamBuilder(
                    stream: fStream,
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
                              onTap: () => onItemCliced(
                                  products.data()['status'], products.id),
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
                                      getStatus(
                                          products.data()['status'], width)
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
              child: Text("En attente d'initialisation",
                  style: TextStyle(color: Colors.white)),
            ));
        break;
      case 2:
        return Container(
          width: width / 5,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Livrée",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        break;
      case 3:
        return Container(
          width: width / 5,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "Annulée",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
        break;
      case 4:
        return Container(
          width: width / 5,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              "En cours",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      default:
        return Text("haaaa");
    }
  }

  void onItemCliced(int status, String id) {
    if (status == 2) {
      Fluttertoast.showToast(
          msg: "Livraison déjà confirmée",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (status == 3) {
      Fluttertoast.showToast(
          msg: "Livraison anulée",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (status == 4) {
      Fluttertoast.showToast(
          msg: "Livraison déja en cours",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      deliveryAssignement(context, id);
    }
  }

  Future deliveryAssignement(context, String documentId) async {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogDeliver(deliveryId: documentId);
        });
  }
}

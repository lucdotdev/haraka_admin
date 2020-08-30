import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haraka_admin/cubits/cubits.dart';
import 'package:haraka_admin/repositories/add_user_repo.dart';

class DialogAddUser extends StatefulWidget {
  DialogAddUser({Key key}) : super(key: key);

  @override
  _DialogAddUserState createState() => _DialogAddUserState();
}

class _DialogAddUserState extends State<DialogAddUser> {
  final AddUserCubit addUserCubit =
      AddUserCubit(addUsersRepository: AddUsersRepository());
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  int account_type = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text('Selectionner un livreur',
            style: TextStyle(color: Colors.red)),
        content: Container(
            width: 500,
            height: double.maxFinite,
            child: BlocConsumer<AddUserCubit, AddUserState>(
              cubit: addUserCubit,
              listener: (context, state) {
                if (state is AddUserSucceded) {
                  Future.delayed(Duration(milliseconds: 1000),
                      () => {Navigator.of(context).pop()});
                }
              },
              builder: (context, state) {
                if (state is AddUserLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AddUserSucceded) {
                  return Center(
                    child: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.green,
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xffF2F5FF),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            enabled: true,
                            border: InputBorder.none,
                            hintText: "Nom",
                            icon: Icon(Icons.account_box)),
                        controller: name,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xffF2F5FF),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            enabled: true,
                            border: InputBorder.none,
                            hintText: "Email",
                            icon: Icon(Icons.email)),
                        controller: email,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xffF2F5FF),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            enabled: true,
                            border: InputBorder.none,
                            hintText: "Mot de passe",
                            icon: Icon(Icons.enhanced_encryption_rounded)),
                        controller: password,
                      ),
                    ),
                  ],
                );
              },
            )),
        actions: <Widget>[
          FlatButton(
              child: Text('Ajouter', style: TextStyle(color: Colors.black)),
              onPressed: () => {
                    if (name.text.isEmpty ||
                        password.text.isEmpty ||
                        email.text.isEmpty)
                      {}
                    else
                      {
                        addUserCubit.addUser({
                          "name": name.text,
                          "email": email.text,
                          "password": password.text,
                          "account_type": account_type
                        }),
                      }
                  })
        ]);
  }
}

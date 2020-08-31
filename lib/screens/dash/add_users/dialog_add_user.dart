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
                    Text("Information:"),
                    TextField(
                      decoration: InputDecoration(
                          enabled: true,
                          hintText: "Nom",
                          icon: Icon(Icons.account_box)),
                      controller: name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          enabled: true,
                          hintText: "Email",
                          icon: Icon(Icons.email)),
                      controller: email,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          enabled: true,
                          hintText: "Mot de passe",
                          icon: Icon(Icons.enhanced_encryption_rounded)),
                      controller: password,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Type de compte:"),
                    RadioListTile(
                        value: 1,
                        groupValue: account_type,
                        title: Text("Business"),
                        onChanged: (value) {
                          setState(() {
                            account_type = value;
                          });
                        }),
                    RadioListTile(
                        value: 2,
                        groupValue: account_type,
                        title: Text("Livreur"),
                        onChanged: (value) {
                          setState(() {
                            account_type = value;
                          });
                        }),
                  ],
                );
              },
            )),
        actions: <Widget>[
          FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              padding: EdgeInsets.all(5),
              color: Colors.green,
              child: Text('Ajouter', style: TextStyle(color: Colors.white)),
              onPressed: () => {
                    if (name.text.isEmpty ||
                        password.text.isEmpty ||
                        email.text.isEmpty)
                      {}
                    else
                      {
                        print(name.value.text),
                        addUserCubit.addUser({
                          "name": name.value.text,
                          "email": email.value.text,
                          "password": password.value.text,
                          "account_type": account_type
                        }),
                      }
                  })
        ]);
  }
}

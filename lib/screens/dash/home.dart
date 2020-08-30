import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haraka_admin/cubits/drawer/drawer_cubit.dart';
import 'package:haraka_admin/screens/dash/add_users/users_list.dart';
import 'package:haraka_admin/screens/dash/drawer.dart';

import 'dashboard/dashboard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;
    // final double heigth = MediaQuery.of(context).size.height;
    // final double lateralDrawerWidth = width / 5;
    return Scaffold(
        backgroundColor: Color(0xffF5F6FA),
        body: Row(children: [
          Expanded(flex: 1, child: LateralDrawer()),
          Expanded(
            flex: 5,
            child: BlocBuilder<DrawerCubit, DrawerState>(
                cubit: context.bloc<DrawerCubit>(),
                builder: (context, state) {
                  if (state is GoToUsers) {
                    return UsersList();
                  }
                  if (state is GoHomePage) {
                    return DeliveryList();
                  }

                  return const DeliveryList();
                }),
          )
        ]));
  }
}

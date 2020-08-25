import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haraka_admin/cubits/drawer/drawer_cubit.dart';

class LateralDrawer extends StatelessWidget {
  const LateralDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // final double heigth = MediaQuery.of(context).size.height;
    final double lateralDrawerWidth = width / 4.4;

    return Container(
      color: Color(0xffFFFFFF),
      width: lateralDrawerWidth,
      child: Column(
        children: [
          Container(
              child: Image.asset(
            'assets/images/haraka_transp.png',
            width: width / 10,
          )),
          BlocBuilder(
              cubit: context.bloc<DrawerCubit>(),
              builder: (context, state) {
                ///Home button cond
                ///
                final _homeCond = state is GoHomePage || state is DrawerInitial;

                ///Chat button cond
                ///
                final _usersCond = state is GoToUsers;

                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(children: [
                    ///DASHBOARD COND
                    ///
                    ///
                    ///
                    FlatButton(
                      onPressed: () => context.bloc<DrawerCubit>().goTohome(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: _homeCond ? Color(0xff053C71) : Colors.grey,
                          ),
                          SizedBox(),
                          Text(
                            'DashBoard',
                            style: TextStyle(
                                color:
                                    _homeCond ? Colors.black : Colors.black87,
                                fontWeight: _homeCond
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )
                        ],
                      ),
                    ),

                    FlatButton(
                      onPressed: () => context.bloc<DrawerCubit>().goToUsers(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.supervisor_account,
                            color: _usersCond ? Color(0xff053C71) : Colors.grey,
                          ),
                          SizedBox(),
                          Text(
                            'Utilisateurs',
                            style: TextStyle(
                                color:
                                    _usersCond ? Colors.black : Colors.black87,
                                fontWeight: _usersCond
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ]),
                );
              })
        ],
      ),
    );
  }
}

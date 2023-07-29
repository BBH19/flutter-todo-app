// ignore_for_file: prefer_const_declarations, sized_box_for_whitespace, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:badges/badges.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/views/cheque_edit.dart';
import 'package:chequeproject/views/cheque_list.dart';
import 'package:chequeproject/views/cheque_list_filtred.dart';
import 'package:chequeproject/views/login/login.dart';
import 'package:chequeproject/views/notification/notification.dart';
import 'package:chequeproject/views/settings/settings_view.dart';
import 'package:gmsoft_pkg/config/global_params.dart';
import 'package:chequeproject/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:gmsoft_pkg/config/menu.dart';
import 'package:gmsoft_pkg/dashboard_item_view.dart';

import 'blocs/Cheque/cheque_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TWO_PI = 3.14 * 2;
  TextStyle style = TextStyle(fontSize: 13, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    GlobalParams.GlobalColor = const Color(0xFF6E4168);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        elevation: 0,
      )),
      initialRoute: UserLogin.Route,
      routes: {
        UserLogin.Route: (ctxRoute) => UserLogin(),
        ChequesFiltred.Route: (ctxRoute) => BlocProvider(
              create: (ctxRoute) => ChequeBloc()..add(LoadChequesEvent()),
              child: ChequesFiltred(),
            ),
        Cheques.Route: (ctxRoute) => BlocProvider(
              create: (ctxRoute) => ChequeBloc()..add(LoadChequesEvent()),
              child: Cheques(),
            ),
        ChequeEditPage.Route: (ctxRoute) => BlocProvider(
              create: (ctxRoute) => ChequeBloc(),
              child: ChequeEditPage(),
            ),
        SettingsView.Route: (ctxRoute) => SettingsView(),
        NotificationView.Route: (ctxRoute) => NotificationView(),
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: GlobalParams.GlobalColor,
        title: const Text(
          "Accueil",
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Open Sans", //GlobalParams.MainfontFamily,
          ),
        ),
        actions: [
          badges.Badge(
            badgeContent: Text(
              '2',
              style: TextStyle(color: Colors.white),
            ),
            badgeStyle: BadgeStyle(badgeColor: Colors.red),
            position: BadgePosition.topStart(top: 5, start: 5),
            child: Column(
              children: [
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctxRoute) => NotificationView(),
                      ),
                    );
                  },
                  icon: Icon(Icons.notifications),
                ),
              ],
            ),
          ),
          IconButton(
              padding: EdgeInsets.all(5),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctxRoute) => SettingsView(
                      previousRoute: "/",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
          child: DashboardItemView(ButtonOptionDashboard.Options)),
    );
  }
}

class ButtonOptionDashboard {
  static List<ButtonOption> Options = const <ButtonOption>[
    ButtonOption(
      route: "/listing",
      text: 'Chéques/Effets',
      iconData: Icons.list_alt,
      arguments: "",
    ),
    ButtonOption(
      route: "/ChequeEdit",
      text: 'Nouveau Chéque',
      iconData: Icons.add_to_photos_outlined,
    ),
    ButtonOption(
      route: "/listing",
      text: 'Chéques/Effets, En Cours',
      iconData: Icons.list_alt,
      arguments: "active",
    ),
     ButtonOption(
      route: "/listing",
      text: 'Chéques/Effets, Transmet',
      iconData: Icons.list_alt,
      arguments: "forwarded",
    ),
      ButtonOption(
      route: "/listing",
      text: 'Chéques/Effets, ImPayé',
      arguments: "unpaid",
      iconData: Icons.list_alt,
    ),
      ButtonOption(
      route: "/listing",
      text: 'Chéques/Effets, Payé',
      arguments: "payed",
      iconData: Icons.list_alt,
    ),


    // ButtonOption(
    //     route: "/listingFiltred",
    //     text: 'Alerts Chéques',
    //     iconData: Icons.filter_frames_outlined),
  ];
}

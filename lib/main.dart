// ignore_for_file: prefer_const_declarations, sized_box_for_whitespace, must_be_immutable, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/views/cheque_edit.dart';
import 'package:chequeproject/views/cheque_list.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/dashbord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/Cheque/cheque_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TWO_PI = 3.14 * 2;
  TextStyle style = TextStyle(fontSize: 13, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        elevation: 0,
      )),
      routes: {
        Cheques.Route: (context) => BlocProvider(
              create: (context) => ChequeBloc()..add(LoadChequesEvent()),
              child: Cheques(),              
            ),
        ChequeEditPage.Route: (context) => BlocProvider(
              create: (context) =>
                  ChequeBloc()..add(AddChequeEvent(data: Cheque())),
              child: ChequeEditPage(),//love you <3
            ),
            
      },
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(),
        appBar: AppBar(
          backgroundColor: GlobalParams.GlobalColor,
          title: const Text(
            "Accueil",
            style: TextStyle(
              color: Colors.white,
              fontFamily: GlobalParams.MainfontFamily,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: DashboardItemView(ButtonOption.Options)),
      ),
    );
  }
}

class ButtonOption {
  const ButtonOption(
      {this.color = const Color(0xff6091AB),
      required this.text,
      required this.route,
      this.isVisible = true});
  final Color color;
  final String text;
  final String route;
  final bool? isVisible;

  static List<ButtonOption> Options = const <ButtonOption>[
    ButtonOption(route: "/listing", text: 'Liste des Chéques'),
    ButtonOption(
      route: "/ChequeEdit",
      text: 'Nouveau Chéque',
    ),
  ];
}

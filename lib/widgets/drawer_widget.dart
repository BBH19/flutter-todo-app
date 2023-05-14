import 'package:chequeproject/widgets/config.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: GlobalParams.GlobalColor,
            ),
            child: Center(),
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: GlobalParams.GlobalColor,
            ),
            title: const Text('List Chéques'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/listing');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_to_photos_outlined,
              color: GlobalParams.GlobalColor,
            ),
            title: const Text('Nouveau Chéque'),
            onTap: () {
              // fermer le menu coulissant et naviguer vers la page de paramètres
              Navigator.pop(context);
              Navigator.pushNamed(context, '/ChequeEdit');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gmsoft_pkg/config/global_params.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/logo1.png"),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt,
              color: GlobalParams.GlobalColor,
            ),
            title: const Text('Liste Chéques'),
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
          ListTile(
            leading: Icon(
              Icons.filter_frames_outlined,
              color: GlobalParams.GlobalColor,
            ),
            title: const Text('Alerts Chéques'),
            onTap: () {
              // fermer le menu coulissant et naviguer vers la page de paramètres
              Navigator.pop(context);
              Navigator.pushNamed(context, '/listingFiltred');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: GlobalParams.GlobalColor,
            ),
            title: const Text('Paramétre'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/setting');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: GlobalParams.GlobalColor,
            ),
            title: const Text('Se Déconnecter'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

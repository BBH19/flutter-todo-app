import 'package:chequeproject/views/settings/service_base.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/underline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsView extends StatefulWidget {
  static String Route = "/setting";
  String? previousRoute = "";
  SettingsView({Key? key, this.previousRoute}) : super(key: key);
  @override
  State<SettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {
  String domainName = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController domainNameController = TextEditingController();
  final String domainNameMessage =
      ' Saisir le nom du domaine avant de continuer';
  var items;

  @override
  void initState() {
    loadDomains();
    BaseService.GET_DOMAIN().then((value) => {
          domainNameController.text = value,
        });
  }

  loadDomains() {
    BaseService.GET_DOMAINS().then((value) => items = value);
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = GlobalParams.GlobalColor;
    Color prevColor = GlobalParams.GlobalColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalParams.GlobalColor,
        iconTheme: IconThemeData(color: GlobalParams.GlobalColor),
        elevation: 0,
        title: const Text(
          "Paramétre",
          style: TextStyle(
            color: Colors.white,
            fontFamily: GlobalParams.MainfontFamily,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, widget.previousRoute.toString());
            }),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 35),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    // SvgPicture.asset("assets/images/shape.svg",
                    //     color: GlobalParams.GlobalColor),
                    // const Text("GMS ERP    ",
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                domainNameMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              TextFieldUnderlineWidget(
                icon: Icons.domain,
                valid: AutovalidateMode.onUserInteraction,
                controller: domainNameController,
                hint: 'Domaine',
                suffix: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: GlobalParams.GlobalColor,
                  ),
                  onSelected: (String value) {
                    domainNameController.text = value;
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                    for (var item in items)
                      PopupMenuItem(value: item, child: Text('$item')),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Column(
              //   children: [
              //     ButtonWidget(
              //       size: MediaQuery.of(context).size,
              //       onPressed: () async {
              //         items = await BaseService.REMOVE_DOMAIN(
              //             domainNameController.text);
              //         GlobalParams.baseUrl = await BaseService.GET_DOMAIN();
              //         domainNameController.text = GlobalParams.baseUrl;
              //       },
              //       text: 'Supprimer',
              //     ),
              //     ButtonWidget(
              //       size: MediaQuery.of(context).size,
              //       onPressed: () async {
              //         if (formKey.currentState!.validate()) {
              //           items = await BaseService.ADD_DOMAIN(
              //               domainNameController.text);
              //           GlobalParams.baseUrl = await BaseService.GET_DOMAIN();
              //         }
              //       },
              //       text: 'Enregistrer',
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalParams.GlobalColor),
                        onPressed: () async {
                          items = await BaseService.REMOVE_DOMAIN(
                              domainNameController.text);
                          GlobalParams.baseUrl = await BaseService.GET_DOMAIN();
                          domainNameController.text = GlobalParams.baseUrl;
                        },
                        child: const Text('Supprimer')),
                  ),
                  const Gap(10),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalParams.GlobalColor),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            items = await BaseService.ADD_DOMAIN(
                                domainNameController.text);
                            GlobalParams.baseUrl =
                                await BaseService.GET_DOMAIN();
                          }
                        },
                        child: const Text('Enregistrer')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: avoid_print, non_constant_identifier_names, sized_box_for_whitespace
import 'dart:convert';

import 'package:chequeproject/main.dart';
import 'package:chequeproject/views/settings/service_base.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/custom_alert_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chequeproject/utils/validators.dart';

class UserLogin extends StatefulWidget {
  static String Route = "/login";

  const UserLogin({Key? key}) : super(key: key);
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMeController = TextEditingController();
  bool? Canscan;
  bool isChecked = false;
  bool validInfos = false;
  @override
  void initState() {
    super.initState();
    LoadSettings();
  }

  Future<void> _login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == 'admin' && password == 'admin') {
      // Rediriger vers la page d'accueil
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          ModalRoute.withName('/home'));
    } else {
      await CustomAlert.show(
          context: context,
          type: AlertType.error,
          desc: 'Infos incorrects',
          onPressed: () {
            Navigator.pop(context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    Image.asset("assets/logo1.png")
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF4F2F2),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                  controller: emailController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    enabledBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    errorBorder: InputBorder.none,
                    floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: GlobalParams.GlobalColor),
                    focusedBorder: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Color(0xff8E8E93),
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                    ),
                    labelText: 'Identifiant/Email',
                    prefixIcon: Icon(
                      Icons.person,
                      color: GlobalParams.GlobalColor,
                      size: 18,
                    ),
                  ),
                  validator: (value) => validators.validateField(value),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xffF4F2F2),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    focusedBorder: InputBorder.none,
                    labelStyle: TextStyle(
                      color: GlobalParams.GlobalColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                    ),
                    labelText: 'Mot de Pass',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: GlobalParams.GlobalColor,
                      size: 18,
                    ),
                  ),
                  validator: (value) => validators.validateField(value),
                ),
              ),
              const SizedBox(height: 15),
              Row(children: [
                Checkbox(
                    activeColor: GlobalParams.GlobalColor,
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        if (!isChecked) {
                          isChecked = true;
                        } else {
                          isChecked = false;
                        }
                      });
                    }),
                const Text("Remember Me ?  ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
              ]),
              const SizedBox(height: 13),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: GlobalParams.GlobalColor,
                    fixedSize: const Size(240, 40)),
                child: const Text(
                  'Se Connecter',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void LoadSettings() async {
    try {
      if (kIsWeb) {
        var jsonResult =
            await DefaultAssetBundle.of(context).loadString("json/config.json");
        final data = await json.decode(jsonResult);
        await BaseService.ADD_DOMAIN(data["domain"]);
      }

      if (kDebugMode) {
        await BaseService.ADD_DOMAIN("http://31.220.89.29:5000/");
      }

      GlobalParams.baseUrl = await BaseService.GET_DOMAIN();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = "";
      String password = "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      if (remeberMe) {
        email = prefs.getString("email") ?? "";
        password = prefs.getString("password") ?? "";
        setState(() {
          isChecked = true;
        });
      }

      if (kDebugMode && email == "" && password == "") {
        email = "admin";
        password = "admin";
      }

      emailController.text = email;
      passwordController.text = password;

      //const AnimationScean();
    } catch (e) {
      print(e);
    }
  }
}

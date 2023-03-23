import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/utils/validators.dart';
import 'package:chequeproject/widgets/textfield_widget.dart';
import 'package:flutter/material.dart'; 
import 'package:collection/collection.dart'; 

class ChequeDataField extends StatefulWidget {
  final Cheque currentObj;
  final bool isUpdate;
  ChequeDataField({Key? key, required this.currentObj, required this.isUpdate})
      : super(key: key);

  @override
  State<ChequeDataField> createState() => ChequeDataFieldState(currentObj, isUpdate);
}

class ChequeDataFieldState extends State<ChequeDataField> {
  Cheque currentObj;
  bool isUpdate;

  static TextEditingController numController = TextEditingController();
  static TextEditingController clientController = TextEditingController();
  static TextEditingController holderController = TextEditingController();
  static TextEditingController montantController = TextEditingController();
  static TextEditingController receptDateController = TextEditingController();
  static TextEditingController echeanceDateController = TextEditingController();
  static TextEditingController isPayedController = TextEditingController();
  static TextEditingController paymentDateController = TextEditingController();
  static TextEditingController attachementController = TextEditingController();


   List<String> isPayedList = ['En cours'];

  String selectedIsPayed = "";
 
  static final _formKey = GlobalKey<FormState>();
  double _fontsize = 15;

  ChequeDataFieldState(this.currentObj, this.isUpdate) {
    numController.text = currentObj.id??'';
    clientController.text = currentObj.client??'';
    holderController.text = currentObj.holder??'';
    selectedIsPayed = isPayedList[0]; 
    if (isUpdate) {
      selectedIsPayed = isPayedList.firstWhereOrNull(
          (type) => type == currentObj.isPayed) ?? isPayedList[0]; 
    }
  }

 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    currentObj.isPayed = selectedIsPayed!; 

    return Center(
        child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: size.height * 0.01),
              TextFieldWidget(
                enabled: !isUpdate,
                validator: (value) {
                 // return validators.validateNumber(value!);
                },
                obj: currentObj,
                controller: numController,
                labeltext: 'Numero',
                valuetext: currentObj.id??"",
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
              ),
              SizedBox(height: size.height * 0.015),
              TextFieldWidget(
                  controller: clientController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                   // return validators.validateField(value!);
                  },
                  obj: currentObj,
                  labeltext: 'Client',
                  valuetext: currentObj.client??''),
              SizedBox(height: size.height * 0.015),
              TextFieldWidget(
                controller: holderController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                validator: (value) {
                  //return validators.validateNumber(value!);
                },
                obj: currentObj,
                valuetext: currentObj.holder!,
                labeltext: 'Holder',
              ),
              SizedBox(height: size.height * 0.015),
              Container(
                  //padding: EdgeInsets.only(top: 8),
                  child: Column(children: [
                Form(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      labelText: 'Type',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          value: selectedIsPayed,
                          onChanged: (newValue) {
                            setState(() {
                              selectedIsPayed = newValue!;
                              // currentObj.type = selectedType.name!;
                              // currentObj.type_id = selectedType.id.toString();
                            });
                          },
                          //decoration: InputDecoration(border: InputBorder.none),
                          items: isPayedList.map<DropdownMenuItem<String>>((items) {
                            return DropdownMenuItem<String>(
                              value: items,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(items),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                )
              ])),
              SizedBox(height: size.height * 0.015),
              Container(
                  //padding: EdgeInsets.only(top: 8),
                  child: Column(children: [
                Form(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      labelText: 'Groupe',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    child:  Text('LOVE YOU , SAHBTI')
                  ),
                )
              ])),
              SizedBox(height: size.height * 0.015),
              Container(
                  //padding: EdgeInsets.only(top: 8),
                  child: Column(children: [
                Form(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      labelText: 'Etat',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    // child: DropdownButtonHideUnderline(
                    //   child: ButtonTheme(
                        // alignedDropdown: true,
                        // child: DropdownButton<clState>(
                        //   isDense: true,
                        //   icon: const Icon(Icons.keyboard_arrow_down),
                        //   value: selectedState,
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       selectedState = newValue!;
                        //       currentObj.etat = selectedState.name!;
                        //       currentObj.state_id = selectedState.id.toString();
                        //     });
                        //   }, 
                        // ),
                    //   ),
                    // ),
                  ),
                )
              ])),
              SizedBox(height: size.height * 0.015),
              Container(
                  //padding: EdgeInsets.only(top: 8),
                  child: Column(children: [
                Form(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      labelText: 'VAT',
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    child: Center(child: Text('LOVE YOU'),)
                      ),
                    ),
                  ]
                )
              ),
              SizedBox(height: size.height * 0.02),
            ])));
  }
}
 
 
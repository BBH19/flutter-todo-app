// // ignore_for_file: unused_field, prefer_final_fields

// import 'package:flutter/material.dart';
// import 'package:chequeproject/models/cheque.dart';
// import 'package:chequeproject/utils/widgect_helper.dart';
// import 'package:chequeproject/widgets/config.dart';
// import 'package:chequeproject/widgets/datepicker_widget.dart';
// import 'package:chequeproject/widgets/dropdown_widget.dart';
// import 'package:chequeproject/widgets/file_picker_widget.dart';
// import 'package:chequeproject/widgets/textfield_widget.dart';
// import 'package:chequeproject/utils/validators.dart';

// class StepperWidget extends StatefulWidget {
//   static final _formKey = GlobalKey<FormState>();
//   Cheque? cheque;
//   @override
//   State<StepperWidget> createState() => _StepperWidgetState();
// }

// class _StepperWidgetState extends State<StepperWidget> {
//  var dateRange = DateTime.now();

//   DateTime? receptDate;

//   DateTime? echeanceDate;

//   DateTime? paiementDate;

//   String selectedPaymentMode = "";

//   int _index = 0;

//   List<bool> hide = [false, true];

//   Cheque? cheque;

//   StepperType stepperType = StepperType.horizontal;

//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//               margin: const EdgeInsets.all(0),
//               type: stepperType,
//               currentStep: _index,
//               onStepCancel: () {
//                 if (_index > 0) {
//                   setState(() {
//                     _index -= 1;
//                   });
//                 }
//               },
//               controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
//                 return Row(
//                   children: <Widget>[
//                     const SizedBox(height: 88.0),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.33,
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: !hide[_index] == true
//                               ? Colors.grey
//                               : GlobalParams.GlobalColor,
//                           padding: const EdgeInsets.all(16.0),
//                           textStyle: const TextStyle(fontSize: 15),
//                         ),
//                         onPressed:
//                             !hide[_index] == true ? null : dtl.onStepCancel,
//                         child: const Text('< Précédent',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.33,
//                       child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: hide[_index] == true
//                               ? Colors.grey
//                               : GlobalParams.GlobalColor,
//                           padding: const EdgeInsets.all(16.0),
//                           textStyle: const TextStyle(fontSize: 15),
//                         ),
//                         onPressed:
//                             hide[_index] == true ? null : dtl.onStepContinue,
//                         child: const Text('Suivant >',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               onStepContinue: () {
//                 if (StepperWidget._formKey.currentState!.validate()) {
//                   if (_index == 0) {
//                     setState(() {
//                       _index += 1;
//                     });
//                   }
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text('Tous les champs sont requis'),
//                     backgroundColor: Colors.red,
//                   ));
//                 }
//               },
//               onStepTapped: (Step) {
//                 // setState(() {
//                 //   _index = index;
//                 // });
//               },
//               steps: <Step>[
//                 Step(
//                   state: _index <= 0 ? StepState.editing : StepState.complete,
//                   isActive: _index >= 0,
//                   title: Text('Général',
//                       style: TextStyle(color: GlobalParams.GlobalColor)),
//                   content: Container(
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                         TextFieldWidget(
//                           validator: (value) {
//                             // validators.validateField(value!);
//                             // return null;
//                             if (value == null || value.isEmpty) {
//                               return '*';
//                             }
//                             return null;
//                           },
//                           obj: cheque!,
//                           controller: idController,
//                           labeltext: 'N° de Cheque',
//                           valuetext:
//                               cheque!.id == null ? "" : cheque!.id.toString(),
//                           keyboardType: const TextInputType.numberWithOptions(
//                               signed: false, decimal: true),
//                         ),
//                         SizedBox(height: size.height * 0.02),
//                         TextFieldWidget(
//                           validator: (value) {
//                             isIdFieldFilled = idController.text.isNotEmpty;
//                             if (value == null || value.isEmpty) {
//                               return 'Veuillez remplir le champs';
//                             }
//                             return null;
//                           },
//                           obj: cheque,
//                           controller: clientController,
//                           labeltext: 'Client ',
//                           valuetext: cheque.client ?? "",
//                           keyboardType: TextInputType.name,
//                         ),
//                         SizedBox(height: size.height * 0.02),
//                         TextFieldWidget(
//                             validator: (value) {
//                               // validators.validateField(value!);
//                               // return null;
//                               if (value == null || value.isEmpty) {
//                                 return '*';
//                               }
//                               return null;
//                             },
//                             obj: cheque,
//                             controller: holderController,
//                             labeltext: 'Propriétaire',
//                             valuetext: cheque.holder ?? "",
//                             keyboardType: TextInputType.name),
//                         SizedBox(height: size.height * 0.02),
//                         TextFieldWidget(
//                           validator: (value) {
//                             validators.validateNumber(value!);
//                             // return null;
//                             if (value == null || value.isEmpty) {
//                               return '*';
//                             }
//                             return null;
//                           },
//                           obj: cheque,
//                           controller: montantController,
//                           labeltext: 'Montant',
//                           valuetext: cheque.montant == null
//                               ? ""
//                               : cheque.montant.toString(),
//                           keyboardType: const TextInputType.numberWithOptions(
//                               signed: false, decimal: true),
//                         ),
//                         SizedBox(height: size.height * 0.02),
//                         DatePickerWidget(
//                           validator: (value) {
//                             // validators.validateField(value!);
//                             // return null;
//                             if (value == null || value.isEmpty) {
//                               return '*';
//                             }
//                             return null;
//                           },
//                           obj: cheque,
//                           controller: receptDateController,
//                           labeltext: 'Date Reception',
//                           valuetext: cheque.receptDate ?? "",
//                           keyboardType: const TextInputType.numberWithOptions(
//                               signed: false, decimal: true),
//                           onChanged: (date) {
//                             isReceptionDateFieldFilled =
//                                 receptDateController.text.isEmpty;
//                             receptionDate =
//                                 date; // stocker la date sélectionnée
//                           },
//                         ),
//                         SizedBox(height: size.height * 0.02),
//                         DatePickerWidget(
//                           validator: (value) {
//                             // validators.validateField(value!);
//                             // return null;
//                             if (value == null || value.isEmpty) {
//                               return '*';
//                             }
//                             return null;
//                           },
//                           obj: cheque,
//                           controller: echeanceDateController,
//                           labeltext: 'Date Echeance',
//                           valuetext: cheque.echeanceDate ?? "",
//                           keyboardType: const TextInputType.numberWithOptions(
//                             signed: false,
//                             decimal: true,
//                           ),
//                           onChanged: (date) {
//                             isEcheanceDateFieldFilled =
//                                 echeanceDateController.text.isEmpty;
//                             if (receptionDate != null &&
//                                 date.isBefore(receptionDate!)) {
//                               echeanceDateController.text = "";
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(const SnackBar(
//                                 content: Text(
//                                     'La date doit être antérieure à la date actuelle'),
//                                 backgroundColor: Colors.red,
//                               ));
//                             }
//                           },
//                         ),
//                         SizedBox(height: size.height * 0.02),
//                         TestPickerWidget(
//                           validator: (value) {
//                             // validators.validateField(value!);
//                             // return null;
//                             if (value == null || value.isEmpty) {
//                               return '*';
//                             }
//                             return null;
//                           },
//                           obj: cheque,
//                           controller: attachementController,
//                           labeltext: 'Piéce Jointe',
//                           valuetext: cheque.attachement ?? "",
//                         ),
//                         // SizedBox(height: size.height * 0.02),
//                       ])),
//                 ),
//                 Step(
//                   state: _index <= 1 ? StepState.editing : StepState.complete,
//                   isActive: _index >= 1,
//                   title: Text("Autre",
//                       style: TextStyle(color: GlobalParams.GlobalColor)),
//                   content: Container(
//                     child: Column(children: [
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       SizedBox(height: size.height * 0.02),
//                       InputDecorator(
//                         decoration: WidgetHelper.getDecoration('Paiement'),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             isDense: true,
//                             value:
//                                 selectedPaymentMode, //widget.cheque.isPayed ??
//                             icon: const Icon(
//                               Icons.keyboard_arrow_down,
//                               size: 20,
//                             ),
//                             onChanged: (newValue) {
//                               // This is called when the user selects an item.
//                               setState(() {
//                                 selectedPaymentMode = newValue!;
//                                 widget.cheque.isPayed = newValue;
//                               });
//                             },
//                             items: paymentStatusList
//                                 .map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value,
//                                     style: TextStyle(
//                                         color: GlobalParams.GlobalColor)),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       DatePickerWidget(
//                         obj: cheque,
//                         controller: paymentDateController,
//                         labeltext: 'Date Paiement',
//                         valuetext: cheque.paymentDate ?? "",
//                         keyboardType: const TextInputType.numberWithOptions(
//                             signed: false, decimal: true),
//                         onChanged: (date) {
//                           if (echeanceDate != null &&
//                               date.isAfter(echeanceDate)) {
//                             paymentDateController.text = "";
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text(
//                                   'La date doit être antérieure à la date actuelle'),
//                               backgroundColor: Colors.red,
//                             ));
//                           }
//                         },
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                     ]),
//                   ),
//                 ),
//               ],
//             ),;
//   }
// }

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/utils/validators.dart';
import 'package:chequeproject/utils/widgect_helper.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/custom_alert_widget.dart';
import 'package:chequeproject/widgets/datepicker_widget.dart';
import 'package:chequeproject/widgets/dropdown_widget.dart';
import 'package:chequeproject/widgets/file_picker_widget.dart';
import 'package:chequeproject/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChequeEditPage extends StatefulWidget {
  static String Route = '/ChequeEdit';
  Cheque? currentObj;
  ChequeEditPage({
    Key? key,
    this.currentObj,
  }) : super(key: key);

  @override
  State<ChequeEditPage> createState() => _ChequeEditPage();
}
 
class _ChequeEditPage extends State<ChequeEditPage> {
  
 
  bool isExpanded = false, isExpanded2 = false;
  List<String> list = <String>['En cours', 'Payé ', 'Non Payé'];
  bool? update;

  int _index = 0;

  List<bool> hide = [true, false];

  StepperType stepperType = StepperType.horizontal;
  bool? isUpdate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (this.widget.currentObj == null) {
      isUpdate ??= false;
      widget.currentObj = Cheque(
          id: '',
          client: '',
          holder: '',
          montant: null,
          receptDate: '',
          echeanceDate: '',
          isPayed: '',
          paymentDate: '',
          attachement: '');
    } else {
      isUpdate ??= true;
    }
    String error = isUpdate! ? 'Erreur de modification' : 'Erreur d\'ajout';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlobalParams.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalParams.GlobalColor,
        elevation: 0,
        title: update!
            ? Text(
                "Cheque N° : ${widget.currentObj!.id}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    fontFamily: 'Open Sans'),
              )
            : const Text(
                "Nouveau Cheque :",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    fontFamily: 'Open Sans'),
              ),
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                // ChequeDataFieldState.idController.text =
                //     ChequeDataFieldState.idController.text;

                // if (ChequeDataFieldState.idController.text != "" &&
                //     ChequeDataFieldState.clientController.text != "" &&
                //     ChequeDataFieldState.holderController.text != "" &&
                //     ChequeDataFieldState.montantController.text != "" &&
                //     ChequeDataFieldState.receptDateController.text != "" &&
                //     ChequeDataFieldState.echeanceDateController.text != "" &&
                //     ChequeDataFieldState.isPayedController.text != "" &&
                //     ChequeDataFieldState.paymentDateController.text != "" &&
                //     ChequeDataFieldState.attachementController.text != "") {

                widget.currentObj!.id = ChequeDataFieldState.idController.text;
                widget.currentObj!.client = ChequeDataFieldState.clientController.text;
                widget.currentObj!.holder = ChequeDataFieldState.holderController.text;
                widget.currentObj!.montant = double.tryParse(
                    ChequeDataFieldState.montantController.text);

                var receiptDate =
                    ChequeDataFieldState.receptDateController.text;
                var echeanceDate =
                    ChequeDataFieldState.echeanceDateController.text;
                var paymentDate =
                    ChequeDataFieldState.paymentDateController.text;

                widget.currentObj!.receptDate = receiptDate;
                widget.currentObj!.echeanceDate = echeanceDate;
                widget.currentObj!.isPayed = ChequeDataFieldState.isPayedController.text;
                widget.currentObj!.paymentDate = paymentDate;
                widget.currentObj!.attachement =
                    ChequeDataFieldState.isPayedController.text;

                print("star save");
                print(widget.currentObj!.client);

                update!
                    ? BlocProvider.of<ChequeBloc>(context)
                        .add(UpdateChequeEvent(
                        data: widget.currentObj!,
                      ))
                    : BlocProvider.of<ChequeBloc>(context).add(AddChequeEvent(
                        data: widget.currentObj!,
                      ));
                // } else {
                //   await CustomAlert.show(
                //       context: context,
                //       type: AlertType.error,
                //       desc: descr,
                //       onPressed: () {
                //         Navigator.pop(context);
                //       });
                // }
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
            bottom: GlobalParams.MainPadding,
            right: GlobalParams.MainPadding,
            left: GlobalParams.MainPadding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          BlocListener<ChequeBloc, ChequeState>(
              bloc: ChequeBloc(),
              listener: (context, state) async {
                print("request state:${state.requestState}");
                if (state.requestState == ChequeRequestState.Loading) {
                  SizedBox(
                    height: size.height * 0.5,
                    // ignore: prefer_const_constructors
                    child: Center(
                        //child: Lottie.asset('assets/animations/loader.json'),
                        ),
                  );
                } else if (state.requestState == ChequeRequestState.Error) {
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.error,
                      desc: 'Erreur de modification',
                      onPressed: () {});
                } else if (state.requestState == ChequeRequestState.Added) {
                  print('Add successful');
                  BlocProvider.of<ChequeBloc>(context)
                      .add(AddChequeEvent(data: widget.currentObj!));
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.success,
                      desc: 'Le cheque a été ajouté avec succès',
                      onPressed: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                      });
                } else if (state.requestState == ChequeRequestState.Updated) {
                  //print('Update successful');
                  BlocProvider.of<ChequeBloc>(context)
                      .add(UpdateChequeEvent(data: widget.currentObj!));
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.success,
                      desc: 'Le Cheque a été mis à jour avec succès',
                      onPressed: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ > 2);
                      });
                }
              },
              child: Column(children: [
                const SizedBox(
                  height: 5.0,
                ),
                ChequeDataField(cheque:widget.currentObj!, isUpdate: update!),
              ]))
        ]),
      ),
    );
  }
}

class ChequeDataField extends StatefulWidget {
  final Cheque cheque;
  bool isUpdate;
  ChequeDataField({Key? key, required this.cheque, required this.isUpdate})
      : super(key: key);

  @override
  State<ChequeDataField> createState() =>
      ChequeDataFieldState(cheque, isUpdate);
}

class ChequeDataFieldState extends State<ChequeDataField> {
  TextEditingController dateinput = TextEditingController();
  var dateRange = DateTime.now();

  int _index = 0;
  List<bool> hide = [false, true];
  String dropdownValue = list.first;
  StepperType stepperType = StepperType.horizontal;
  late Cheque cheque;
  late bool isUpdate;
  static TextEditingController idController = TextEditingController();
  static TextEditingController clientController = TextEditingController();
  static TextEditingController holderController = TextEditingController();
  static TextEditingController montantController = TextEditingController();
  static TextEditingController receptDateController = TextEditingController();
  static TextEditingController echeanceDateController = TextEditingController();
  static TextEditingController isPayedController = TextEditingController();
  static TextEditingController paymentDateController = TextEditingController();
  static TextEditingController attachementController = TextEditingController();

  ChequeDataFieldState(this.cheque, this.isUpdate) {
    idController.text = cheque.id ?? "";
    clientController.text = cheque.client ?? "";
    holderController.text = cheque.holder ?? "";
    montantController.text = cheque.montant == null ? "" : cheque.montant.toString();
    receptDateController.text = cheque.receptDate ?? "";
    echeanceDateController.text = cheque.echeanceDate ?? "";
    isPayedController.text = cheque.isPayed ?? "";
    paymentDateController.text = cheque.paymentDate ?? "";
    attachementController.text = cheque.attachement ?? "";
  }

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            height: MediaQuery.of(context).size.height * 0.8),
        child: Theme(
          data: ThemeData(
            canvasColor: Colors.white,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: GlobalParams.GlobalColor,
                  background: GlobalParams.GlobalColor,
                  secondary: Colors.grey,
                ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stepper(
              margin: const EdgeInsets.all(0),
              type: stepperType,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
                return Row(
                  children: <Widget>[
                    const SizedBox(height: 88.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: !hide[_index] == true
                              ? Colors.grey
                              : GlobalParams.GlobalColor,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed:
                            !hide[_index] == true ? null : dtl.onStepCancel,
                        child: const Text('< Précédent',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: hide[_index] == true
                              ? Colors.grey
                              : GlobalParams.GlobalColor,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed:
                            hide[_index] == true ? null : dtl.onStepContinue,
                        child: const Text('Suivant >',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                );
              },
              onStepContinue: () {
                if (_index <= 0) {
                  setState(() {
                    _index += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  _index = index;
                });
              },
              steps: <Step>[
                Step(
                  state: _index <= 0 ? StepState.editing : StepState.complete,
                  isActive: _index >= 0,
                  title: Text('Général',
                      style: TextStyle(color: GlobalParams.GlobalColor)),
                  content: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        TextFieldWidget(
                          validator: (value) {
                            validators.validateField(value!);
                            return null;
                          },
                          obj: cheque,
                          controller: idController,
                          labeltext: 'N° de Cheque',
                          valuetext: cheque.id ?? "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            validators.validateField(value!);
                            return null;
                          },
                          obj: cheque,
                          controller: clientController,
                          labeltext: 'Client ',
                          valuetext: cheque.client ?? "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            validators.validateField(value!);
                            return null;
                          },
                          obj: cheque,
                          controller: holderController,
                          labeltext: 'Propriétaire',
                          valuetext: cheque.holder ?? "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            validators.validateField(value!);
                            return null;
                          },
                          obj: cheque,
                          controller: montantController,
                          labeltext: 'Montant',
                          valuetext: cheque.montant == null
                              ? ""
                              : cheque.montant.toString(),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        DatePickerWidget(
                          obj: cheque,
                          controller: receptDateController,
                          labeltext: 'Date Reception',
                          valuetext: cheque.receptDate ?? "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        DatePickerWidget(
                          obj: cheque,
                          controller: echeanceDateController,
                          labeltext: 'Date Echeance',
                          valuetext: cheque.echeanceDate ?? "",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TestPickerWidget(
                          obj: cheque,
                          controller: attachementController,
                          labeltext: 'Piéce Jointe',
                          valuetext: cheque.attachement ?? "",
                        ),
                        SizedBox(height: size.height * 0.02),
                      ])),
                ),
                Step(
                  state: _index <= 1 ? StepState.editing : StepState.complete,
                  isActive: _index >= 1,
                  title: Text("Autre",
                      style: TextStyle(color: GlobalParams.GlobalColor)),
                  content: Container(
                    child: Column(children: [
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      InputDecorator(
                        decoration: WidgetHelper.getDecoration('Paiement'),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        color: GlobalParams.GlobalColor)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      DatePickerWidget(
                        obj: cheque,
                        controller: receptDateController,
                        labeltext: 'Date Paiement',
                        valuetext: cheque.receptDate ?? "",
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                      ),
                      SizedBox(height: size.height * 0.02),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


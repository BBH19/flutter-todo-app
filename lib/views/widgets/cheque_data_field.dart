// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/utils/widgect_helper.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:gap/gap.dart';
import 'package:gmsoft_pkg/config/global_params.dart';
import 'package:chequeproject/widgets/textfield_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:chequeproject/utils/validators.dart';
import 'package:gmsoft_pkg/datepicker_widget.dart';
import 'package:gmsoft_pkg/text_picker_widget.dart';

import '../../services/helper_service.dart';

class ChequeDataField extends StatefulWidget {
  final Cheque cheque;
  bool isUpdate;
  GlobalKey<FormState>? formKey;
  int index;
  ChequeDataField(
      {Key? key,
      this.formKey,
      required this.cheque,
      required this.isUpdate,
      required this.index})
      : super(key: key);

  @override
  State<ChequeDataField> createState() =>
      ChequeDataFieldState(cheque, isUpdate, formKey ?? GlobalKey<FormState>());
}

enum SingingCharacter { lafayette, jefferson }

class ChequeDataFieldState extends State<ChequeDataField> {
  TextEditingController dateinput = TextEditingController();
  var dateRange = DateTime.now();
  DateTime? receptDate;
  DateTime? echeanceDate;
  DateTime? paiementDate;
  String selectedPaymentMode = "";
  String selectedBank = "";


  List<bool> hide = [false, true];
  GlobalKey<FormState> _formKey;

  bool isReceptionDateFieldFilled = false;
  bool isEcheanceDateFieldFilled = false;

  StepperType stepperType = StepperType.horizontal;
  late Cheque cheque;
  late bool isUpdate;
  static TextEditingController numController = TextEditingController();
  static TextEditingController clientController = TextEditingController();
  static TextEditingController forwardToController = TextEditingController();
  static TextEditingController holderController = TextEditingController();
  static TextEditingController montantController = TextEditingController();
  static TextEditingController receptDateController = TextEditingController();
  static TextEditingController echeanceDateController = TextEditingController();
  static TextEditingController paymentDateController = TextEditingController();
  static TextEditingController attachementController = TextEditingController();
  static TextEditingController reasonController = TextEditingController();
  static TextEditingController paymentReasonController =
      TextEditingController();

  ChequeDataFieldState(this.cheque, this.isUpdate, this._formKey) {
    late bool isEmptyOrNull = cheque.bank == null || cheque.bank!.isEmpty;

    numController.text = cheque.num == null ? "" : cheque.num.toString();
    clientController.text = cheque.client ?? "";
    holderController.text = cheque.holder ?? "";
    montantController.text =
        cheque.montant == null ? "" : cheque.montant.toString();
    receptDateController.text = cheque.receptDate ?? "";
    echeanceDateController.text = cheque.echeanceDate ?? "";
    paymentDateController.text = cheque.paymentDate ?? "";
    attachementController.text = cheque.attachement ?? "";
    paymentReasonController.text = cheque.reasonPayment ?? "";
    reasonController.text = cheque.reason ?? "";
    selectedPaymentMode =
        isUpdate ? cheque.isPayed! : HelperService.paymentStatusList.first;
    selectedBank = !isUpdate || isEmptyOrNull
        ? HelperService.bankList.first
        : cheque.bank!;
  }
  //love u :*

  bool checkCanEdit() {
    bool canEdit = true;
    // var echeance = DateTime.tryParse(echeanceDateController.text);
    // if (echeance != null) canEdit = echeance.isBefore(DateTime.now());

    return canEdit;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    SizedBox sizedBox002 = SizedBox(height: size.height * 0.02);
    FilePickerResult? result;

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
          child: Form(
            key: _formKey,
            child: Stepper(
              margin: const EdgeInsets.all(0),
              type: stepperType,
              currentStep: widget.index,
              onStepCancel: () {
                if (widget.index > 0) {
                  setState(() {
                    widget.index -= 1;
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
                          backgroundColor: !hide[widget.index] == true
                              ? Colors.grey
                              : GlobalParams.GlobalColor,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: !hide[widget.index] == true
                            ? null
                            : dtl.onStepCancel,
                        child: const Text('< Précédent',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: hide[widget.index] == true
                              ? Colors.grey
                              : GlobalParams.GlobalColor,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: hide[widget.index] == true
                            ? null
                            : dtl.onStepContinue,
                        child: const Text('Suivant >',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                );
              },
              onStepContinue: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.index == 0) {
                    setState(() {
                      widget.index += 1;
                    });
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Des champs requis'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              onStepTapped: (index) {
                setState(() {
                  widget.index = index;
                });
              },
              steps: <Step>[
                Step(
                  state: widget.index <= 0
                      ? StepState.editing
                      : StepState.complete,
                  isActive: widget.index >= 0,
                  title: Text('Général',
                      style: TextStyle(color: GlobalParams.GlobalColor)),
                  content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getChequeOrEffetWidget(),
                        sizedBox002,
                        TextFieldWidget(
                          validator: (value) => validators.validateField(value),
                          obj: cheque,
                          controller: clientController,
                          labeltext: 'Client ',
                          valuetext: cheque.client ?? "",
                          keyboardType: TextInputType.name,
                        ),
                        sizedBox002,
                        TextPickerWidget(
                            validator: (value) =>
                                validators.validateField(value),
                            obj: cheque,
                            controller: holderController,
                            labeltext: 'Propriétaire',
                            valuetext: cheque.holder ?? "",
                            keyboardType: TextInputType.name,
                            on_changed_function: () async {
                              holderController.text = clientController.text;
                            }),
                        sizedBox002,
                        TextFieldWidget(
                          validator: (value) => validators.validateField(value),
                          obj: cheque,
                          controller: montantController,
                          labeltext: 'Montant',
                          valuetext: cheque.montant == null
                              ? ""
                              : cheque.montant.toString(),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        sizedBox002,
                        getDatesWidget(),
                        sizedBox002,
                        SizedBox(
                          height: 35,
                          child: InputDecorator(
                            decoration: WidgetHelper.getDecoration(''),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                itemHeight: 49,
                                isDense: true,
                                value: selectedBank,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedBank = newValue!;
                                    widget.cheque.bank = newValue;
                                  });
                                },
                                items: HelperService.bankList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color: GlobalParams.GlobalColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          fontFamily: 'Open Sans'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        sizedBox002,
                        TextPickerWidget(
                          obj: cheque,
                          controller: attachementController,
                          labeltext: 'Piéce Jointe',
                          valuetext: cheque.attachement ?? "",
                          on_changed_function: () async {
                            result = await FilePicker.platform
                                .pickFiles(allowMultiple: true);
                            if (result == null) {
                              //print("No file selected");
                            } else {
                              setState(() {});
                              result?.files.forEach((element) {
                                //print(element.name);
                                attachementController.text = element.name;
                              });
                            }
                          },
                        ),
                        sizedBox002,
                        TextPickerWidget(
                            obj: cheque,
                            height: null,
                            controller: reasonController,
                            labeltext: 'Motif',
                            valuetext: cheque.reason ?? "",
                            maxLines: 4,
                            keyboardType: TextInputType.none,
                            on_changed_function: () async {
                              reasonController.text = '';
                            }),
                      ]),
                ),
                Step(
                  state: widget.index <= 1
                      ? StepState.editing
                      : StepState.complete,
                  isActive: widget.index >= 1,
                  title: Text("Paiment",
                      style: TextStyle(color: GlobalParams.GlobalColor)),
                  content: Container(
                    child: Column(children: [
                      ...List.generate(7, (index) => sizedBox002),
                      SizedBox(
                        height: 35,
                        child: InputDecorator(
                          decoration: WidgetHelper.getDecoration('Paiement'),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              value: selectedPaymentMode,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                              onChanged: !checkCanEdit()
                                  ? null
                                  : (newValue) {
                                      setState(() {
                                        selectedPaymentMode = newValue!;
                                        widget.cheque.isPayed = newValue;
                                      });
                                    },
                              items: HelperService.paymentStatusList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                      ),
                      sizedBox002,
                      DatePickerWidget(
                        obj: cheque,
                        controller: paymentDateController,
                        labeltext: 'Date Paiement',
                        valuetext: cheque.paymentDate ?? "",
                        enabled: checkCanEdit(),
                        onChanged: (date) {
                          isReceptionDateFieldFilled =
                              receptDateController.text.isEmpty;
                          var echeanceDate = DateTime.tryParse(
                              ChequeDataFieldState.echeanceDateController.text);
                          if (echeanceDate != null &&
                              date.isBefore(echeanceDate)) {
                            receptDateController.text = "";
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'La date doit être antérieure à la date actuelle'),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                      ),
                      sizedBox002,
                      TextFieldWidget(
                        obj: cheque,
                        controller: forwardToController,
                        labeltext: 'Récépteur',
                        valuetext: cheque.forwardTo ?? "",
                        keyboardType: TextInputType.name,
                      ),
                      sizedBox002,
                      TextPickerWidget(
                          obj: cheque,
                          height: null,
                          controller: paymentReasonController,
                          labeltext: 'Remarque',
                          valuetext: cheque.reasonPayment ?? "",
                          maxLines: 4,
                          keyboardType: TextInputType.none,
                          on_changed_function: () async {
                            paymentReasonController.text = '';
                          }),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  getDatesWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(children: [
          Expanded(
              child: DatePickerWidget(
            validator: (value) => validators.validateField(value),
            obj: cheque,
            controller: receptDateController,
            labeltext: 'Date Reception',
            valuetext: cheque.receptDate ?? "",
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: true),
            onChanged: (date) {
              isReceptionDateFieldFilled = receptDateController.text.isEmpty;
            },
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: DatePickerWidget(
              obj: cheque,
              controller: echeanceDateController,
              labeltext: 'Date Echeance',
              valuetext: cheque.echeanceDate ?? "",
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              onChanged: (date) {
                isEcheanceDateFieldFilled = echeanceDateController.text.isEmpty;
                var receptionDate = DateTime.tryParse(
                    ChequeDataFieldState.receptDateController.text);
                if (receptionDate != null && date.isBefore(receptionDate)) {
                  echeanceDateController.text = "";
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('La date doit être antérieure à la date actuelle'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
          )
        ]));
  }

  getChequeOrEffetWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFieldWidget(
              validator: (value) => validators.validateNumber(value),
              obj: cheque,
              controller: numController,
              labeltext: 'N° de Cheque',
              valuetext: cheque.num ?? "",
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: true),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CustomRadioButton(
            elevation: 0,
            absoluteZeroSpacing: true,
            selectedBorderColor: GlobalParams.GlobalColor,
            unSelectedBorderColor: GlobalParams.GlobalColor,
            unSelectedColor: Theme.of(context).canvasColor,
            defaultSelected: widget.cheque.isEffet,
            enableShape: true, 
            buttonLables: const [
              'Cheque',
              'Effet',
            ],
            buttonValues: const [
              "Cheque",
              "Effet",
            ],
            buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.black,
                textStyle: TextStyle(fontSize: 16)),
            radioButtonValue: (value) {
              print(value);
              widget.cheque.isEffet = value;
            },
            selectedColor: GlobalParams.GlobalColor,
          ),
        ],
      ),
    );
  }
}

import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/datepicker_widget.dart';
import 'package:chequeproject/widgets/dropdown_widget.dart';
import 'package:chequeproject/widgets/file_picker_widget.dart';
import 'package:chequeproject/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  TextEditingController dateinput = TextEditingController();
  var dateRange = DateTime.now();

  int _index = 0;
  List<bool> hide = [false, true];

  StepperType stepperType = StepperType.horizontal;
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
              margin: EdgeInsets.all(0),
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
                    SizedBox(height: 88.0),
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
                        SizedBox(height: size.height * 0.02),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            return null;
                            //validateNumber(value!);
                          },
                          obj: "null",
                          
                          //controller: TextEditingController.fromValue(),
                          labeltext: 'N° de Cheque',
                          valuetext: "cheque.id ",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            return null;
                            // validateNumber(value!);
                          },
                          obj: "null",
                          //controller: TextEditingController.fromValue(),
                          labeltext: 'Client ',
                          valuetext: "cheque.id ",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            return null;
                            // validateNumber(value!);
                          },
                          obj: "null",
                          //controller: TextEditingController.fromValue(),
                          labeltext: 'Propriétaire',
                          valuetext: "cheque.id ",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        TextFieldWidget(
                          validator: (value) {
                            return null;
                            // validateNumber(value!);
                          },
                          obj: "null",
                          //controller: TextEditingController.fromValue(),
                          labeltext: 'Montant',
                          valuetext: "cheque.id ",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        DatePickerWidget(
                          validator: (value) {
                            return null;
                            // validateNumber(value!);
                          },
                          obj: "null",
                          //controller: TextEditingController.fromValue(),
                          labeltext: 'Date Reception',
                          valuetext: "cheque.id ",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                        SizedBox(height: size.height * 0.02),
                        DatePickerWidget(
                          validator: (value) {
                            return null;
                            // validateNumber(value!);
                          },
                          obj: "null",
                          //controller: TextEditingController.fromValue(),
                          labeltext: 'Date Echeance',
                          valuetext: "cheque.id ",
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
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
                      DropdownButtonExample(),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(height: size.height * 0.02),
                      DatePickerWidget(
                        validator: (value) {
                          return null;
                          // validateNumber(value!);
                        },
                        obj: "null",
                        //controller: TextEditingController.fromValue(),
                        labeltext: 'Date Paiement',
                        valuetext: "cheque.id ",
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TestPickerWidget(
                        validator: (value) {
                          return null;
                          // validateNumber(value!);
                        },
                        obj: "null",
                        //controller: TextEditingController.fromValue(),
                        labeltext: 'Piéce Jointe',
                        valuetext: "cheque.id ",
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

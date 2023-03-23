import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/views/widgets/cheque_data_field.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/custom_alert_widget.dart';
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: GlobalParams.GlobalColor,
          elevation: 0,
          title: isUpdate!
              ? Text(
                  "Client  ${widget.currentObj!.client}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      fontFamily: 'Open Sans'),
                )
              : const Text(
                  "Ajouter Client",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                      fontFamily: 'Open Sans'),
                ),
          actions: [
            IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  print(ChequeDataFieldState.clientController.text);
                  // if (
                  //     ChequeDataFieldState.numController.text != "" &&
                  //     ChequeDataFieldState.numController.text != "" &&
                  //     ChequeDataFieldState.clientController.text != "") {
                  widget.currentObj!.id =
                      ChequeDataFieldState.numController.text;
                  widget.currentObj!.client =
                      ChequeDataFieldState.clientController.text;
                  widget.currentObj!.holder =
                      ChequeDataFieldState.holderController.text;

                  isUpdate!
                      ? BlocProvider.of<ChequeBloc>(context)
                          .add(UpdateChequeEvent(data: widget.currentObj!))
                      : BlocProvider.of<ChequeBloc>(context).add(AddChequeEvent(
                          data: widget.currentObj!,
                        ));
                  // } else {
                  // await CustomAlert.show(
                  //     context: context,
                  //     type: AlertType.error,
                  //     desc: error,
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     });
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
                listener: (context, state) async {
                  print("request state:${state.requestState}");

                  // data is loading
                  if (state.requestState == ChequeRequestState.Adding ||
                      state.requestState == ChequeRequestState.Loading ||
                      state.requestState == ChequeRequestState.Updating) {
                    // SizedBox(
                    //   height: size.height * 0.5,
                    //   child: Center(
                    //       // child: Lottie.asset('assets/animations/loader.json'),
                    //       ),
                    // );
                  } else if (state.requestState == ChequeRequestState.Error) {
                    await CustomAlert.show(
                        context: context,
                        type: AlertType.error,
                        desc: error,
                        onPressed: () {
                          Navigator.pop(context);
                        });
                  }

                  // data is loading
                  // data is loaded
                  else if (state.requestState == ChequeRequestState.Added ||
                      state.requestState == ChequeRequestState.Updated) {
                    print('Update successful');
                    BlocProvider.of<ChequeBloc>(context)
                        .add(LoadChequesEvent());
                    await CustomAlert.show(
                        context: context,
                        type: AlertType.success,
                        desc: 'Le Produit a été enregistré avec succès',
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
                  ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: MediaQuery.of(context).size.height * 0.82),
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
                            controlsBuilder:
                                (BuildContext ctx, ControlsDetails dtl) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: hide[_index] == true
                                            ? Colors.grey
                                            : GlobalParams.GlobalColor,
                                        padding: const EdgeInsets.all(16.0),
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                      ),
                                      onPressed: hide[_index] == true
                                          ? null
                                          : dtl.onStepCancel,
                                      child: const Text('< Précédent',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.33,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: !hide[_index] == true
                                            ? Colors.grey
                                            : GlobalParams.GlobalColor,
                                        padding: const EdgeInsets.all(16.0),
                                        textStyle:
                                            const TextStyle(fontSize: 15),
                                      ),
                                      onPressed: !hide[_index] == true
                                          ? null
                                          : dtl.onStepContinue,
                                      child: const Text('Suivant >',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              );
                            },
                            onStepContinue: () {
                              if (_index <= 1) {
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
                                  state: _index <= 0
                                      ? StepState.editing
                                      : StepState.complete,
                                  isActive: _index >= 0,
                                  title: Text('Général',
                                      style: TextStyle(
                                          color: GlobalParams.GlobalColor)),
                                  content: ChequeDataField(
                                      currentObj: widget.currentObj!,
                                      isUpdate: isUpdate!)),
                              Step(
                                  state: _index <= 1
                                      ? StepState.editing
                                      : StepState.complete,
                                  isActive: _index >= 1,
                                  title: Text("Contact",
                                      style: TextStyle(
                                          color: GlobalParams.GlobalColor)),
                                  content: Text(
                                      "LOVE YOU BOUCHRATI") // ContactDataField(client: widget.currentObj!, isUpdate: isUpdate!)),
                                  )
                            ],
                          ),
                        ),
                      )),
                ]))
          ]),
        ));
  }
}

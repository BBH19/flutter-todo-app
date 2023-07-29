// ignore_for_file: unused_local_variable

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/views/widgets/cheque_data_field.dart';
import 'package:gmsoft_pkg/config/global_params.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmsoft_pkg/custom_alert_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChequeEditPage extends StatefulWidget {
  static String Route = '/ChequeEdit';
  Cheque? currentObj;
  int index;
  ChequeEditPage({Key? key, this.currentObj, this.index = 0}) : super(key: key);

  @override
  State<ChequeEditPage> createState() => _ChequeEditPage();
}

class _ChequeEditPage extends State<ChequeEditPage> {
  StepperType stepperType = StepperType.horizontal;
  bool isUpdate = true;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.currentObj == null) {
      isUpdate = false;
      widget.currentObj = Cheque(
          id: null,
          client: '',
          holder: '',
          montant: null,
          receptDate: DateTime.now().toString(),
          echeanceDate: '',
          isPayed: 'En cours',
          isEffet: 'Cheque',
          bank: '',
          paymentDate: '',
          attachement: '');
    }
    String error = isUpdate ? 'Erreur de modification' : 'Erreur d\'ajout';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlobalParams.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: GlobalParams.GlobalColor,
        elevation: 0,
        title: Text(
          isUpdate ? "Chéque N° ${widget.currentObj!.num}" : "Nouveau Chéque",
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                var isValidateForm = formState.currentState!.validate();
                if (isValidateForm) {
                  widget.currentObj!.num =
                      ChequeDataFieldState.numController.text;
                  widget.currentObj!.client =
                      ChequeDataFieldState.clientController.text;
                  widget.currentObj!.holder =
                      ChequeDataFieldState.holderController.text;
                  widget.currentObj!.montant = double.tryParse(
                      ChequeDataFieldState.montantController.text);
                  widget.currentObj!.receptDate = ChequeDataFieldState
                      .receptDateController.text
                      .replaceFirst('T', ' ');
                  widget.currentObj!.echeanceDate = ChequeDataFieldState
                      .echeanceDateController.text
                      .replaceFirst('T', ' ');
                  widget.currentObj!.paymentDate = ChequeDataFieldState
                      .paymentDateController.text
                      .replaceFirst('T', ' ');
                  widget.currentObj!.attachement =
                      ChequeDataFieldState.attachementController.text;
                  isUpdate
                      ? BlocProvider.of<ChequeBloc>(context)
                          .add(UpdateChequeEvent(
                          data: widget.currentObj!,
                        ))
                      : BlocProvider.of<ChequeBloc>(context).add(AddChequeEvent(
                          data: widget.currentObj!,
                        ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Des champs requis'),
                    backgroundColor: Colors.red,
                  ));
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.error,
                      desc: error,
                      onPressed: () {
                        Navigator.pop(context);
                      });
                }
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
                if (state.requestState == ChequeRequestState.Adding ||
                    state.requestState == ChequeRequestState.Loading ||
                    state.requestState == ChequeRequestState.Updating) {
                  SizedBox(
                    height: size.height * 0.5,
                    child: Center(
                      child: Lottie.asset('assets/animations/loader.json'),
                    ),
                  );
                } else if (state.requestState == ChequeRequestState.Error) {
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.error,
                      desc: error,
                      onPressed: () {
                        Navigator.pop(context);
                      });
                } else if (state.requestState == ChequeRequestState.Added) {
                  print('Saved successful');
                  BlocProvider.of<ChequeBloc>(context).add(LoadChequesEvent());
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.success,
                      desc: 'Le cheque a été enregistré avec succès',
                      onPressed: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ > 1);
                      });
                } else if (state.requestState == ChequeRequestState.Updated) {
                  print('Update successful');
                  BlocProvider.of<ChequeBloc>(context).add(LoadChequesEvent());
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.success,
                      desc: 'Le chéque a été mis à jour avec succès',
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
                ChequeDataField(
                    cheque: widget.currentObj!,
                    isUpdate: isUpdate,
                    index: widget.index,
                    formKey: formState),
              ]))
        ]),
      ),
    );
  }
}

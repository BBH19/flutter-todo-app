// ignore_for_file: unused_local_variable

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/utils/widgect_helper.dart';
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
  List<String> list = <String>['En cours', 'Payé ', 'Non Payé'];
  int _index = 0;
  StepperType stepperType = StepperType.horizontal;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    print('current object');
    Size size = MediaQuery.of(context).size;
    if (widget.currentObj == null) {
      isUpdate = false;
      widget.currentObj = Cheque(
          id: null,
          client: '',
          holder: '',
          montant: null,
          receptDate: '',
          echeanceDate: '',
          isPayed: '',
          paymentDate: '',
          attachement: '');
    } else {
      isUpdate = true;
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
          isUpdate
              ? "Cheque N° : ${widget.currentObj!.id}"
              : "Nouveau Cheque :",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 19,
              fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                if (ChequeDataFieldState.idController.text != "" &&
                    ChequeDataFieldState.clientController.text != "" &&
                    ChequeDataFieldState.holderController.text != "" &&
                    ChequeDataFieldState.montantController.text != "" &&
                    ChequeDataFieldState.receptDateController.text != "" &&
                    ChequeDataFieldState.echeanceDateController.text != "" &&
                    ChequeDataFieldState.paymentDateController.text != "" &&
                    ChequeDataFieldState.attachementController.text != "") {
                  widget.currentObj!.id =
                      int.tryParse(ChequeDataFieldState.idController.text);
                  widget.currentObj!.client =
                      ChequeDataFieldState.clientController.text;
                  widget.currentObj!.holder =
                      ChequeDataFieldState.holderController.text;
                  widget.currentObj!.montant = double.tryParse(
                      ChequeDataFieldState.montantController.text);
                  widget.currentObj!.receptDate =
                      ChequeDataFieldState.receptDateController.text;
                  widget.currentObj!.echeanceDate =
                      ChequeDataFieldState.echeanceDateController.text;
                  widget.currentObj!.paymentDate =
                      ChequeDataFieldState.paymentDateController.text;
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
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.error,
                      desc: 'CHAMPS VIDE',
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
                if (state.isLoadingState) {
                  WidgetHelper.LoadingWidget(size);
                } else if (state.requestState == ChequeRequestState.Error) {
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.error,
                      desc: 'Erreur de modification',
                      onPressed: () {
                        Navigator.pop(context);
                      });
                } else if (state.requestState == ChequeRequestState.Added ||
                    state.requestState == ChequeRequestState.Updated) {
                  print('Saved successful');
                  BlocProvider.of<ChequeBloc>(context).add(LoadChequesEvent());
                  await CustomAlert.show(
                      context: context,
                      type: AlertType.success,
                      desc: 'Le cheque a été enregistré avec succès',
                      onPressed: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 1);
                      });
                }
              },
              child: Column(children: [
                const SizedBox(
                  height: 5.0,
                ),
                ChequeDataField(cheque: widget.currentObj!, isUpdate: isUpdate),
              ]))
        ]),
      ),
    );
  }
}

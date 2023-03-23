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
  bool isExpanded = false, isExpanded2 = false;
  List<String> list = <String>['En cours', 'Payé ', 'Non Payé'];

  int _index = 0;

  List<bool> hide = [true, false];

  StepperType stepperType = StepperType.horizontal;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    print('current object');
    Size size = MediaQuery.of(context).size;
    // if (widget.currentObj == null) {
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
    // } else {
    //   isUpdate ??= true;
    // }
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
                // if (ChequeDataFieldState.idController.text != "" &&
                //     ChequeDataFieldState.clientController.text != "" &&
                //     ChequeDataFieldState.holderController.text != "" &&
                //     ChequeDataFieldState.montantController.text != "" &&
                //     ChequeDataFieldState.receptDateController.text != "" &&
                //     ChequeDataFieldState.echeanceDateController.text != "" &&
                //     ChequeDataFieldState.isPayedController.text != "" &&
                //     ChequeDataFieldState.paymentDateController.text != "" &&
                //     ChequeDataFieldState.attachementController.text != "") {

                widget.currentObj!.id =
                    int.tryParse(ChequeDataFieldState.idController.text);
                widget.currentObj!.client =
                    ChequeDataFieldState.clientController.text;
                widget.currentObj!.holder =
                    ChequeDataFieldState.holderController.text;
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
                widget.currentObj!.paymentDate = paymentDate;
                widget.currentObj!.attachement =
                    ChequeDataFieldState.attachementController.text;

                print("star save");
                print(widget.currentObj!.client);

                isUpdate
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
                //       desc: error,
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
                ChequeDataField(cheque: widget.currentObj!, isUpdate: isUpdate),
              ]))
        ]),
      ),
    );
  }
}

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChequeItem extends StatefulWidget {
  Cheque cheque;
  ChequeItem({Key? key, required this.cheque}) : super(key: key);

  @override
  State<ChequeItem> createState() => _ChequeItemState();
}

class _ChequeItemState extends State<ChequeItem> {
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cheque N° : ${widget.cheque.id!}",
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: GlobalParams.GlobalColor,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(_context,
          //             MaterialPageRoute(builder: (context) {
          //           return BlocProvider.value(
          //             value: BlocProvider.of<ChequeBloc>(_context),
          //           );
          //         }));
          //       },
          //       icon: const Icon(
          //         Icons.print,
          //         size: 20,
          //       ))
          // ],
        ),
        body: PageOne(
          cheque: widget.cheque,
        ));
  }
}

class PageOne extends StatefulWidget {
  Cheque cheque;
  PageOne({required this.cheque}) : super();

  @override
  PageOneState createState() => PageOneState(cheque: cheque);
}

class PageOneState extends State<PageOne> {
  Cheque cheque;
  PageOneState({required this.cheque});
  String? statut;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BuildContext _context = context;
    //return Text('data1');
    return BlocListener<ChequeBloc, ChequeState>(
      listener: (context, state) {},
      child: ListView(children: <Widget>[
        DetailsCard(
          key_: 'N° Chéque ',
          value: widget.cheque.id.toString(),
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Client',
          value: widget.cheque.client ?? "",
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Propriétaire ',
          value: widget.cheque.holder!,
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Montant',
          value: widget.cheque.montant.toString(),
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Date de Retour',
          value: widget.cheque.receptDate ?? " - ",
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Date Echeance ',
          value: widget.cheque.echeanceDate ?? " - ",
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Banque ',
          value: widget.cheque.bank ?? " - ",
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Piéce Jointe ',
          value: widget.cheque.attachement ?? " - ",
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Statut de Paiment',
          value: widget.cheque.isPayed,
          minwidth: 120,
        ),
        DetailsCard(
          key_: 'Date de Paiment',
          value: widget.cheque.paymentDate ?? " - ",
          minwidth: 120,
        ),
      ]),
    );
  }
}

// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/views/cheque_add.dart';
import 'package:chequeproject/widgets/config.dart';
import 'package:chequeproject/widgets/error_widget.dart';
import 'package:chequeproject/widgets/header.dart';
import 'package:chequeproject/widgets/itemcard_widget.dart';
import 'package:chequeproject/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cheques extends StatelessWidget {
  static String Route = '/listing';

  const Cheques({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChequeBloc()..add(LoadCheques()),
        ),
      ],
      child: ChequeHome(size: size),
    );
  }
}

class ChequeHome extends StatelessWidget {
  const ChequeHome({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;

    return SafeArea(
        child: Scaffold(
      backgroundColor: GlobalParams.backgroundColor,
      appBar: AppBar(
        title: const Text('Chéques'),
        elevation: 0,
        backgroundColor: GlobalParams.GlobalColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Navigator.push(_context, MaterialPageRoute(builder: (context) {
                return BlocProvider.value(
                    value: BlocProvider.of<ChequeBloc>(_context),
                    child: AddChequeView());
              }));
            },
          ),
        ],
      ),
      body: ChequeBody(size: size),
    ));
  }
}

class ChequeBody extends StatelessWidget {
  const ChequeBody({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Header(
              size: size / 1.5,
              child: SearchField(
                  size: size / 1.4,
                  onchanged_function: (String value) {
                    BlocProvider.of<ChequeBloc>(context).add(
                      SearchChequeEvent(value,
                          BlocProvider.of<ChequeBloc>(context).state.cheques),
                    );
                  }),
            ),
            Expanded(
              child: BlocBuilder<ChequeBloc, ChequeState>(
                  builder: (context, state) {
                if (state.requestState == RequestState.Loading ||
                    state.requestState == RequestState.Searching) {
                  return SizedBox(
                    height: size.height * 0.5,
                  );
                } else if (state.requestState == RequestState.Loaded ||
                    state.requestState == RequestState.SearchLoaded) {
                  List<Cheque>? chequeList =
                      state.requestState == RequestState.Loaded
                          ? state.cheques
                          : state.search_result;
                  return Container(
                    height: size.height * 0.78,
                    padding: EdgeInsets.only(
                        top: GlobalParams.MainPadding / 2,
                        left: GlobalParams.MainPadding / 3,
                        right: GlobalParams.MainPadding / 4),
                    child: ListView.builder(
                      itemCount: chequeList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var currentItem = chequeList![index];
                        return ItemCard(
                            size: size,
                            var1: currentItem.client,
                            var2: currentItem.holder,
                            var3: currentItem.isPayed == null
                                ? "N/A"
                                : currentItem.isPayed == true
                                    ? "Payé"
                                    : "Umpayé",
                            var4:
                                '${chequeList[index].montant} | ${chequeList[index].receptDate}',
                            color: GlobalParams.GlobalColor);
                      },
                    ),
                  );
                }
                return ErrorWithRefreshButtonWidget(
                  button_function: () {
                    BlocProvider.of<ChequeBloc>(context).add(LoadCheques());
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

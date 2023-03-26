// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unrelated_type_equality_checks

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/views/cheque_edit.dart';
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
    return BlocProvider(
      create: (context) => ChequeBloc()..add(LoadChequesEvent()),
      child: _chequeHome(size: size),
    );
  }
}

// ignore: camel_case_types
class _chequeHome extends StatelessWidget {
  const _chequeHome({
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
                    child: ChequeEditPage());
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
                          BlocProvider.of<ChequeBloc>(context).state.data),
                    );
                  }),
            ),
            Expanded(
              child: BlocBuilder<ChequeBloc, ChequeState>(
                  builder: (context, state) {
                if (state.requestState == ChequeRequestState.Loading ||
                    state.requestState == ChequeRequestState.Searching) {
                  return SizedBox(
                    height: size.height * 0.5,
                  );
                } else if (state.requestState == ChequeRequestState.Loaded ||
                    state.requestState == ChequeRequestState.SearchLoaded) {
                  List<Cheque>? chequeList =
                      state.requestState == ChequeRequestState.Loaded
                          ? state.data
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
                            var1: currentItem.id.toString(),
                            var2:
                                '${currentItem.client} | ${currentItem.holder}',
                            var3: currentItem.isPayed,
                            var4:
                                '${chequeList[index].montant} | ${chequeList[index].receptDate}',
                            color: GlobalParams.GlobalColor);
                      },
                    ),
                  );
                }
                return ErrorWithRefreshButtonWidget(
                  button_function: () {
                    BlocProvider.of<ChequeBloc>(context)
                        .add(LoadChequesEvent());
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

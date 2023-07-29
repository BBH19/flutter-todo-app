// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unrelated_type_equality_checks, avoid_unnecessary_containers, prefer_const_constructors

import 'package:chequeproject/blocs/Cheque/cheque_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';
import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/views/cheque_edit.dart';
import 'package:chequeproject/views/cheque_items.dart';
import 'package:gmsoft_pkg/botom_modal_widget_child.dart'; 
import 'package:gmsoft_pkg/config/global_params.dart'; 
import 'package:chequeproject/widgets/itemcard_widget.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmsoft_pkg/bottom_modal_widget.dart';
import 'package:gmsoft_pkg/error_with_refresh_button_widget.dart';
import 'package:gmsoft_pkg/header_widget.dart';
import 'package:gmsoft_pkg/search_field_widget.dart';
import 'package:lottie/lottie.dart';

class ChequesFiltred extends StatelessWidget {
  static String Route = '/listingFiltred';

  const ChequesFiltred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ChequeBloc()..add(LoadChequesFiltredEvent(15)),
      child: _chequeHome(size: size),
    );
  }
}

// ignore: camel_case_types
class _chequeHome extends StatelessWidget {
  _chequeHome({
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
        title: const Text('Alerts Chéques'),
        elevation: 0,
        backgroundColor: GlobalParams.GlobalColor,
      ),
      body: ChequeBody(size: size),
    ));
  }
}

class ChequeBody extends StatelessWidget {
  ChequeBody({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  int index = 1;

  @override
  Widget build(BuildContext context) {
    BuildContext _context = context;
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
                if (state.isLoadingState) {
                  return SizedBox(
                    height: size.height * 0.5,
                    child: Center(
                      child: Lottie.asset('assets/loader.json'),
                    ),
                  );
                } else if (state.requestState == ChequeRequestState.Filtred ||
                    state.requestState == ChequeRequestState.SearchLoaded) {
                  List<Cheque>? chequeList =
                      state.requestState == ChequeRequestState.Filtred
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
                          onPressed: () {
                            showCustomizedModalBottom(
                                context,
                                Expanded(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Container(
                                          child: Text(
                                              "Chéque : ${chequeList[index].id} - ${chequeList[index].isPayed}",
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color:
                                                      GlobalParams.GlobalColor,
                                                  fontFamily: GlobalParams
                                                      .MainfontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15))),
                                      const SizedBox(height: 5),
                                      ModalBottomChildWidget(
                                          text: "Details du Chéque",
                                          icon: Icons.list_alt_outlined,
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return BlocProvider.value(
                                                value:
                                                    BlocProvider.of<ChequeBloc>(
                                                        _context),
                                                child: ChequeItem(
                                                  cheque: chequeList[index],
                                                ),
                                              );
                                            }));
                                          }),
                                      ModalBottomChildWidget(
                                          text: "Modifier Chéque",
                                          icon: Icons.edit,
                                          onTap: () {
                                            Navigator.push(_context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      ChequeBloc>(_context),
                                                  child: ChequeEditPage(
                                                    currentObj: currentItem,
                                                  ));
                                            }));
                                          }),
                                      ModalBottomChildWidget(
                                          text:
                                              "Marker Paiment/impaiment Chéque",
                                          icon: Icons.monetization_on,
                                          onTap: () {
                                            Navigator.push(_context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      ChequeBloc>(_context),
                                                  child: ChequeEditPage(
                                                    currentObj: currentItem,
                                                    index: 1,
                                                  ));
                                            }));
                                          }),
                                    ],
                                  ),
                                ),
                                size * 0.40);
                          },
                          size: size,
                          var1: currentItem.id.toString(),
                          var2: '${currentItem.client} | ${currentItem.holder}',
                          var3: currentItem.isPayed,
                          icon: currentItem.isPayed == 'Payé '
                              ? const Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Color.fromARGB(255, 5, 107, 9),
                                )
                              : currentItem.isPayed == 'En cours'
                                  ? const Icon(
                                      Icons.replay,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                          var4:
                              '${chequeList[index].montant} | ${chequeList[index].receptDate}',
                          color: GlobalParams.GlobalColor,
                        );
                      },
                    ),
                  );
                }
                return ErrorWithRefreshButtonWidget(
                  button_function: () {
                    BlocProvider.of<ChequeBloc>(context)
                        .add(LoadChequesFiltredEvent(15));
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

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:chequeproject/models/cheque.dart';

enum RequestState {
  Loaded,
  Loading,
  Error,
  None,
  Searching,
  SearchLoaded,
  Adding,
  Added,
  Updating,
  Updated
}

class ChequeState {
  List<Cheque> cheques = [];
  List<Cheque>? search_result;
  RequestState requestState;
  String errorMessage;

  ChequeState(
      {required this.cheques,
      required this.requestState,
      required this.errorMessage,
      this.search_result});

  List<Object> get props => [
        cheques,
        requestState,
        errorMessage,
      ];
}

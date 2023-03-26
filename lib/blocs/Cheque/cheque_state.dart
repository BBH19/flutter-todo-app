// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:chequeproject/models/cheque.dart';

enum ChequeRequestState {
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
  List<Cheque> data = [];
  List<Cheque>? search_result;
  ChequeRequestState requestState;
  String errorMessage;

  ChequeState(
      {required this.data,
      required this.requestState,
      required this.errorMessage,
      this.search_result});

  List<Object> get props => [
        data,
        requestState,
        errorMessage,
      ];

  bool get isLoadingState {
    return requestState == ChequeRequestState.Adding ||
        requestState == ChequeRequestState.Loading ||
        requestState == ChequeRequestState.Updating;
  }
}

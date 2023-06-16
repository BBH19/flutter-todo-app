// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:chequeproject/models/cheque_notif.dart';

enum ChequeNotifRequestState {
  Loaded,
  Loading,
  Filtred,
  Filtring,
  Error,
  None,
  Searching,
  SearchLoaded,
  Adding,
  Added,
  Updating,
  Updated
}

class ChequeNotifState {
  List<ChequeNotif> data = [];
  List<ChequeNotif>? search_result;
  ChequeNotifRequestState requestState;
  String errorMessage;

  ChequeNotifState(
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
    return requestState == ChequeNotifRequestState.Adding ||
        requestState == ChequeNotifRequestState.Loading ||
        requestState == ChequeNotifRequestState.Filtring ||
        requestState == ChequeNotifRequestState.Searching ||
        requestState == ChequeNotifRequestState.Updating;
  }
}

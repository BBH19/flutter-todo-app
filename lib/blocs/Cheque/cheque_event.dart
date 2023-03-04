//part of 'vendor_bloc.dart';
// ignore_for_file: override_on_non_overriding_member

import 'package:chequeproject/models/cheque.dart';

abstract class ChequeEvent {
  const ChequeEvent();
  @override
  List<Object> get props => [];
}

class LoadCheques extends ChequeEvent {
  List<Cheque> cheques = [];
  @override
  List<Object> get props => [cheques];
}

class AddChequeEvent extends ChequeEvent {
  Cheque cheque;

  AddChequeEvent({required this.cheque});

  @override
  List<Object> get props => [cheque];
}

class UpdateChequeEvent extends ChequeEvent {
  Cheque cheque;

  UpdateChequeEvent({required this.cheque});
  @override
  List<Object> get props => [cheque];
}

class SearchChequeEvent extends ChequeEvent {
  String search_value;
  List<Cheque> cheque_list = [];

  SearchChequeEvent(this.search_value, this.cheque_list);

  @override
  List<Object> get props => [search_value, cheque_list];
}

class InitializingEvent extends ChequeEvent {}

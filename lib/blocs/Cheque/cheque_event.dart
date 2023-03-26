import 'package:chequeproject/models/cheque.dart';

abstract class ChequeEvent {
  const ChequeEvent();

  List<Object> get props => [];
}

class LoadChequesEvent extends ChequeEvent {
  List<Cheque> cheques = [];
  @override
  List<Object> get props => [cheques];
}

class AddChequeEvent extends ChequeEvent {
  Cheque data;

  AddChequeEvent({required this.data});

  @override
  List<Object> get props => [data];
}

class UpdateChequeEvent extends ChequeEvent {
  Cheque data;

  UpdateChequeEvent({required this.data});
  @override
  List<Object> get props => [data];
}

class SearchChequeEvent extends ChequeEvent {
  String searchValue;
  List<Cheque> data = [];

  SearchChequeEvent(this.searchValue, this.data);

  @override
  List<Object> get props => [searchValue, data];
}

class InitializingEvent extends ChequeEvent {}

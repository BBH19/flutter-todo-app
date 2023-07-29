import 'package:chequeproject/models/cheque.dart';

abstract class ChequeEvent {
  const ChequeEvent();

  List<Object> get props => [];
}

class LoadChequesEvent extends ChequeEvent {
  late String route;
  List<Cheque> cheques = [];

  LoadChequesEvent({this.route = ""});
  @override
  List<Object> get props => [cheques, route];
}

class LoadChequesFiltredEvent extends ChequeEvent {
  int days;
  List<Cheque> cheques = [];
  LoadChequesFiltredEvent(this.days);
  @override
  List<Object> get props => [days, cheques];
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

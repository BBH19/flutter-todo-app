import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/models/cheque_notif.dart';

abstract class ChequeNotifEvent {
  const ChequeNotifEvent();

  List<Object> get props => [];
}

class LoadChequesNotifEvent extends ChequeNotifEvent {
  List<ChequeNotif> cheques_notif = [];
  @override
  List<Object> get props => [cheques_notif];
}

class LoadChequesNotifFiltredEvent extends ChequeNotifEvent {
  int days;
  List<ChequeNotif> cheques_notif = [];
  LoadChequesNotifFiltredEvent(this.days);
  @override
  List<Object> get props => [days, cheques_notif];
}

class AddChequeNotifEvent extends ChequeNotifEvent {
  ChequeNotif data;

  AddChequeNotifEvent({required this.data});

  @override
  List<Object> get props => [data];
}



// class SearchChequeNotifEvent extends ChequeNotifEvent {
//   String searchValue;
//   List<Cheque> data = [];

//   SearchChequeNotifEvent(this.searchValue, this.data);

//   @override
//   List<Object> get props => [searchValue, data];
// }

class InitializingEvent extends ChequeNotifEvent {}

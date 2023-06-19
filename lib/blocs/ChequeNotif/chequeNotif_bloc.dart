import 'package:chequeproject/blocs/ChequeNotif/chequeNotif_event.dart';
import 'package:chequeproject/blocs/ChequeNotif/chequeNotif_state.dart';
import 'package:chequeproject/models/cheque_notif.dart';
import 'package:chequeproject/services/chequeNotifService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChequeNotifBloc extends Bloc<ChequeNotifEvent, ChequeNotifState> {
  ChequeNotifBloc()
      : super(ChequeNotifState(
            data: const [],
            requestState: ChequeNotifRequestState.Loading,
            errorMessage: '')) {
              
    on<LoadChequesNotifEvent>((event, emit) async {
      emit(ChequeNotifState(
          data: const [],
          requestState: ChequeNotifRequestState.Loading,
          errorMessage: ''));
      try {
        List<ChequeNotif> data = await ChequeNotifService.getAll();
        emit(ChequeNotifState(
            data: data,
            requestState: ChequeNotifRequestState.Loaded,
            errorMessage: 'good'));
      } catch (e) {
        if (kDebugMode) {
          print("error on block cheque bloc : $e");
        }
        emit(ChequeNotifState(
            data: const [],
            requestState: ChequeNotifRequestState.Error,
            errorMessage: "error"));
      }
    });
    on<LoadChequesNotifFiltredEvent>((event, emit) async {
      emit(ChequeNotifState(
          data: const [],
          requestState: ChequeNotifRequestState.Filtring,
          errorMessage: ''));
      try {
        List<ChequeNotif> result = await ChequeNotifService.getFiltred(event.days);
        emit(ChequeNotifState(
            data: result,
            requestState: ChequeNotifRequestState.Filtred,
            errorMessage: 'check filtred days ${event.days}'));
      } catch (e) {
        if (kDebugMode) {
          print("error on block cheque bloc : $e");
        }
        emit(ChequeNotifState(
            data: const [],
            requestState: ChequeNotifRequestState.Error,
            errorMessage: "error"));
      }
    });

    // on<SearchChequeEvent>((event, emit) async {
    //   try {
    //     emit(ChequeNotifState(
    //         data: event.data,
    //         requestState: ChequeNotifRequestState.Searching,
    //         errorMessage: '',
    //         search_result: []));

    //     List<Cheque> searchResult = [];
    //     for (var i = 0; i < event.data.length; i++) {
    //       var cheque = event.data[i];
    //       var searchValue = event.searchValue.toLowerCase();

    //       if (cheque.client!.toLowerCase().startsWith(searchValue) ||
    //           cheque.holder!.toLowerCase().startsWith(searchValue) ||
    //           cheque.id!.toString().toLowerCase().startsWith(searchValue)) {
    //         searchResult.add(event.data[i]);
    //       }
    //     }
    //     emit(ChequeNotifState(
    //         data: event.data,
    //         requestState: ChequeNotifRequestState.SearchLoaded,
    //         errorMessage: '',
    //         search_result: searchResult));
    //   } catch (e) {
    //     emit(ChequeNotifState(
    //         data: [],
    //         requestState: ChequeNotifRequestState.Error,
    //         errorMessage: "error"));
    //   }
    // });

    on<AddChequeNotifEvent>((event, emit) async {
      try {
        emit(ChequeNotifState(
            data: state.data,
            requestState: ChequeNotifRequestState.Adding,
            errorMessage: ''));
        if (kDebugMode) {
          print("Adding cheque Notif event");
        }
        await ChequeNotifService.add(event.data );
        emit(ChequeNotifState(
            data: state.data,
            requestState: ChequeNotifRequestState.Added,
            errorMessage: ''));
        if (kDebugMode) {
          print("Adding cheque event");
        }
      } catch (e) {
        if (kDebugMode) {
          print('errorr catch');
        }
        emit(ChequeNotifState(
            data: state.data,
            requestState: ChequeNotifRequestState.Error,
            errorMessage: e.toString()));
      }
    });

    on<InitializingEvent>((event, emit) async {
      emit(ChequeNotifState(
          data: [], requestState: ChequeNotifRequestState.None, errorMessage: ''));
      if (kDebugMode) {
        print("initializing event");
      }
    });

   
  }
}

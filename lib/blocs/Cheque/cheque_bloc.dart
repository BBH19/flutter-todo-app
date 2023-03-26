import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/services/chequeservice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent, ChequeState> {
  ChequeBloc()
      : super(ChequeState(
            data: const [],
            requestState: ChequeRequestState.Loading,
            errorMessage: '')) {
    on<LoadChequesEvent>((event, emit) async {
      emit(ChequeState(
          data: const [],
          requestState: ChequeRequestState.Loading,
          errorMessage: ''));
      try {
        List<Cheque> cheques = await ChequeService.getAll();
        emit(ChequeState(
            data: cheques,
            requestState: ChequeRequestState.Loaded,
            errorMessage: 'good'));
      } catch (e) {
        if (kDebugMode) {
          print("error on block cheque bloc : $e");
        }
        emit(ChequeState(
            data: const [],
            requestState: ChequeRequestState.Error,
            errorMessage: "error"));
      }
    });

    on<SearchChequeEvent>((event, emit) async {
      try {
        emit(ChequeState(
            data: event.data,
            requestState: ChequeRequestState.Searching,
            errorMessage: '',
            search_result: []));

        List<Cheque> searchResult = [];
        for (var i = 0; i < event.data.length; i++) {
          var cheque = event.data[i];
          var searchValue = event.searchValue.toLowerCase();

          if (cheque.client!.toLowerCase().startsWith(searchValue) ||
              cheque.holder!.toLowerCase().startsWith(searchValue) ||
              cheque.id!.toString().toLowerCase().startsWith(searchValue)) {
            searchResult.add(event.data[i]);
          }
        }
        emit(ChequeState(
            data: event.data,
            requestState: ChequeRequestState.SearchLoaded,
            errorMessage: '',
            search_result: searchResult));
      } catch (e) {
        emit(ChequeState(
            data: [],
            requestState: ChequeRequestState.Error,
            errorMessage: "error"));
      }
    });

    on<AddChequeEvent>((event, emit) async {
      try {
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Adding,
            errorMessage: ''));
        if (kDebugMode) {
          print("Adding cheque event");
        }
        await ChequeService.add(event.data);
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Added,
            errorMessage: ''));
        if (kDebugMode) {
          print("Adding cheque event");
        }
      } catch (e) {
        if (kDebugMode) {
          print('errorr catch');
        }
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Error,
            errorMessage: e.toString()));
      }
    });

    on<InitializingEvent>((event, emit) async {
      emit(ChequeState(
          data: [], requestState: ChequeRequestState.None, errorMessage: ''));
      if (kDebugMode) {
        print("initializing event");
      }
    });
  }
}

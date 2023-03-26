// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/services/chequeservice.dart';
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
        print("error on block cheque bloc : $e");
        emit(ChequeState(
            data: const [],
            requestState: ChequeRequestState.Error,
            errorMessage: "error"));
      }
    });

    on<SearchChequeEvent>((event, emit) async {
      try {
        emit(ChequeState(
            data: event.cheque_list,
            requestState: ChequeRequestState.Searching,
            errorMessage: '',
            search_result: []));

        List<Cheque> search_result = [];
        for (var i = 0; i < event.cheque_list.length; i++) {
          var cheque = event.cheque_list[i];
          var searchValue = event.search_value.toLowerCase();

          if (cheque.client!.toLowerCase().startsWith(searchValue) ||
              cheque.holder!.toLowerCase().startsWith(searchValue) ||
              cheque.id!.toString().toLowerCase().startsWith(searchValue)) {
            search_result.add(event.cheque_list[i]);
          }
        }
        emit(ChequeState(
            data: event.cheque_list,
            requestState: ChequeRequestState.SearchLoaded,
            errorMessage: '',
            search_result: search_result));
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
        print("add cheque event");

        var data = await ChequeService.add(event.data);

        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Added,
            errorMessage: ''));
        print('no error');
      } catch (e) {
        print('errorr catch');
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Error,
            errorMessage: e.toString()));
      }
    });

    on<InitializingEvent>((event, emit) async {
      emit(ChequeState(
          data: [], requestState: ChequeRequestState.None, errorMessage: ''));
      print("initializing event");
    });
  }
}

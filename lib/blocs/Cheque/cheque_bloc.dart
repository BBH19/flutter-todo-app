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
          errorMessage: 'mmm'));
      try {
        List<Cheque> cheques = [];
        await ChequeService.getAll().then((value) => cheques = value);
        emit(ChequeState(
            data: cheques,
            requestState: ChequeRequestState.Loaded,
            errorMessage: 'good'));
      } catch (e) {
        print("error on block vendor bloc : $e");
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
          if (event.cheque_list[i].client!
                  .startsWith(event.search_value.toLowerCase()) ||
              event.cheque_list[i].holder!
                  .toLowerCase()
                  .startsWith(event.search_value.toLowerCase())) {
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
        print("add vendor event");
        await ChequeService.add(event.data).then((value) {
          if (value) {
            print("added");
            emit(ChequeState(
                data: state.data,
                requestState: ChequeRequestState.Added,
                errorMessage: ''));
          } else {
            print("error");
            emit(ChequeState(
                data: state.data,
                requestState: ChequeRequestState.Error,
                errorMessage: 'error'));
          }
        });
      } catch (e) {
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Error,
            errorMessage: 'error'));
      }
    });

    on<InitializingEvent>((event, emit) async {
      emit(ChequeState(
          data: [], requestState: ChequeRequestState.None, errorMessage: ''));
      print("initializing event");
    });
  }
}

// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:chequeproject/models/cheque.dart';
import 'package:chequeproject/services/chequeservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chequeproject/blocs/Cheque/cheque_event.dart';
import 'package:chequeproject/blocs/Cheque/cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent, ChequeState> {
  ChequeBloc()
      : super(ChequeState(
            cheques: const [],
            requestState: RequestState.Loading,
            errorMessage: '')) {
    on<LoadChequesEvent>((event, emit) async {
      emit(ChequeState(
          cheques: const [],
          requestState: RequestState.Loading,
          errorMessage: 'mmm'));
      try {
        List<Cheque> cheques = [];
        await ChequeService.getAll().then((value) => cheques = value);
        emit(ChequeState(
            cheques: cheques,
            requestState: RequestState.Loaded,
            errorMessage: 'good'));
      } catch (e) {
        print("error on block vendor bloc : $e");
        emit(ChequeState(
            cheques: const [],
            requestState: RequestState.Error,
            errorMessage: "error"));
      }
    });

    on<SearchChequeEvent>((event, emit) async {
      try {
        emit(ChequeState(
            cheques: event.cheque_list,
            requestState: RequestState.Searching,
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
            cheques: event.cheque_list,
            requestState: RequestState.SearchLoaded,
            errorMessage: '',
            search_result: search_result));
      } catch (e) {
        emit(ChequeState(
            cheques: [],
            requestState: RequestState.Error,
            errorMessage: "error"));
      }
    });

    on<AddChequeEvent>((event, emit) async {
      try {
        emit(ChequeState(
            cheques: state.cheques,
            requestState: RequestState.Adding,
            errorMessage: ''));
        print("add vendor event");
        await ChequeService.add(event.data).then((value) {
          if (value) {
            print("added");
            emit(ChequeState(
                cheques: state.cheques,
                requestState: RequestState.Added,
                errorMessage: ''));
          } else {
            print("error");

            emit(ChequeState(
                cheques: state.cheques,
                requestState: RequestState.Error,
                errorMessage: 'error'));
          }
        });
      } catch (e) {
        emit(ChequeState(
            cheques: state.cheques,
            requestState: RequestState.Error,
            errorMessage: 'error'));
      }
    });

    on<InitializingEvent>((event, emit) async {
      emit(ChequeState(
          cheques: [], requestState: RequestState.None, errorMessage: ''));
      print("initializing event");
    });
  }
}

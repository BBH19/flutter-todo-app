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
        var cheques = await ChequeService.getAll();
        emit(ChequeState(
            data: cheques,
            requestState: ChequeRequestState.Loaded,
            errorMessage: 'good'));
      } catch (e) { 
        emit(ChequeState(
            data: const [],
            requestState: ChequeRequestState.Error,
            errorMessage: e.toString()));
      }
    });
    on<LoadChequesFiltredEvent>((event, emit) async {
      emit(ChequeState(
          data: const [],
          requestState: ChequeRequestState.Filtring,
          errorMessage: ''));
      try {
        List<Cheque> result = await ChequeService.getFiltred(event.days);
        emit(ChequeState(
            data: result,
            requestState: ChequeRequestState.Filtred,
            errorMessage: 'check filtred days ${event.days}'));
      } catch (e) { 
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
          if (cheque.client!.toLowerCase().contains(searchValue) ||
              cheque.holder!.toLowerCase().contains(searchValue) ||
              cheque.num!.toString().toLowerCase().contains(searchValue)) {
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
         await ChequeService.add(event.data);
         
          emit(ChequeState(
                      data: state.data,
                      requestState: ChequeRequestState.Added,
                      errorMessage: ''));        
      } catch (e) { 
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Error,
            errorMessage: e.toString()));
      }
    });

    on<InitializingEvent>((event, emit) async {
      emit(ChequeState(
          data: [], requestState: ChequeRequestState.None, errorMessage: '')); 
    });

    on<UpdateChequeEvent>((event, emit) async {
      try {
        emit(ChequeState(
            data: state.data,
            requestState: ChequeRequestState.Updating,
            errorMessage: ''));
        print("update cheque event");
        await ChequeService.update(event.data).then((value) {
          if (value) {
            emit(ChequeState(
                data: state.data,
                requestState: ChequeRequestState.Updated,
                errorMessage: ''));
          } else {
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
  }
}

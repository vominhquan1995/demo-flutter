import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_flutter/screens/examples/search_results/service/service_search_results.dart';
import 'package:equatable/equatable.dart';

part 'search_results_event.dart';
part 'search_results_state.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvent, SearchResultsState> {
  SearchResultsService service;
  SearchResultsBloc({this.service});
  @override
  SearchResultsState get initialState => SearchResultsInitial();
  @override
  Stream<SearchResultsState> mapEventToState(
    SearchResultsEvent event,
  ) async* {
    if (event is SearchData) {
      var data = await service.searchData().then((data) => {});
      yield LoadedData(list: []);
    }
  }
}

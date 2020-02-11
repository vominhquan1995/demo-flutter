import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:demo_flutter/screens/examples/search/model/search_model.dart';
import 'package:demo_flutter/screens/examples/search/service/service_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

const String KEY_SEARCH = 'history_seach';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchService service;
  SearchBloc({@required this.service});
  @override
  SearchBlocState get initialState => SearchBlocInitial();

  @override
  Stream<SearchBlocState> mapEventToState(
    SearchBlocEvent event,
  ) async* {
    if (event is InitData) {
      List<KeyHot> topKey = await service.getHotKey();
      await Future.delayed(const Duration(milliseconds: 1000), () {});
      yield LoadedData( topKey: topKey);
    }
  }
}

part of 'search_results_bloc.dart';

abstract class SearchResultsEvent extends Equatable {
  const SearchResultsEvent();
}

class SearchData extends SearchResultsEvent {
  @override
  String toString() => 'SearchData';
  @override
  // TODO: implement props
  List<Object> get props => [];
}

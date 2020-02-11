part of 'search_results_bloc.dart';

abstract class SearchResultsState extends Equatable {
  const SearchResultsState();
}

class SearchResultsInitial extends SearchResultsState {
  @override
  List<Object> get props => [];
}

class LoadedData extends SearchResultsState {
  final List<dynamic> list;
  LoadedData({this.list});
  @override
  String toString() => 'LoadedData';
  @override
  List<Object> get props => [list];
}

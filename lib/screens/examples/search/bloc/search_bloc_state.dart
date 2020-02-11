part of 'search_bloc_bloc.dart';

abstract class SearchBlocState extends Equatable {
  const SearchBlocState();
}

class SearchBlocInitial extends SearchBlocState {
  @override
  List<Object> get props => [];
}

class InitStateSearch implements SearchBlocState {
  @override
  String toString() => 'InitStateSearch';
  @override
  List<Object> get props => [];
}

class LoadedData implements SearchBlocState {
  List<KeyHot> topKey;
  LoadedData({this.topKey});
  @override
  String toString() => 'LoadedData';
  @override
  List<Object> get props => [topKey];
}

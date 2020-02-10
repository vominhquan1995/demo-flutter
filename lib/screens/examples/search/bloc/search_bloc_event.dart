part of 'search_bloc_bloc.dart';

abstract class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();
}

class InitData extends SearchBlocEvent {
  InitData();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

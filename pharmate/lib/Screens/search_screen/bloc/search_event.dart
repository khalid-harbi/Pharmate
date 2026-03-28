part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchRequestEvent extends SearchEvent {
  final String searchText;

  SearchRequestEvent({required this.searchText});
}

class DetailsRequestEvent extends SearchEvent {
  final String brandName;

  DetailsRequestEvent({required this.brandName});
}

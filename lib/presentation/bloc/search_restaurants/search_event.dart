part of 'search_bloc.dart';

sealed class SearchEvent {}

class GetAllSearchEvent extends SearchEvent {
  final String query;

  GetAllSearchEvent({required this.query});
}

part of 'search_bloc.dart';

sealed class SearchState {}

final class GetAllRestaurantsInitial extends SearchState {}

final class GetAllRestaurantsLoading extends SearchState {}

final class GetAllRestaurantsLoaded extends SearchState {
  final RestaurantSearchResult searchlistModel;

  GetAllRestaurantsLoaded({required this.searchlistModel});
}

final class GetAllRestaurantsDataEmpty extends SearchState {}

final class GetAllRestaurantsError extends SearchState {}

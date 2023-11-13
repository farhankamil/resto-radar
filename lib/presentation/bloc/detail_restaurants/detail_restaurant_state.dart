part of 'detail_restaurant_bloc.dart';

@immutable
sealed class DetailRestaurantState {}

final class DetailRestaurantInitial extends DetailRestaurantState {}

final class DetailRestaurantLoading extends DetailRestaurantState {}

final class DetailRestaurantLoaded extends DetailRestaurantState {
  final RestaurantDetailModel detailModel;

  DetailRestaurantLoaded({required this.detailModel});
}

final class DetailRestaurantError extends DetailRestaurantState {}

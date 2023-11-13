part of 'detail_restaurant_bloc.dart';

@immutable
sealed class DetailRestaurantEvent {}

class GetDetailEvent extends DetailRestaurantEvent {
  final String id;

  GetDetailEvent({required this.id});
}

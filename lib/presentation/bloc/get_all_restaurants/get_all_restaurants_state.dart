part of 'get_all_restaurants_bloc.dart';

@immutable
sealed class GetAllListState {}

final class GetAllListInitial extends GetAllListState {}

final class GetAllListLoading extends GetAllListState {}

final class GetAllListLoaded extends GetAllListState {
  final RestaurantListModel listModel;

  GetAllListLoaded({required this.listModel});
}

class GetAllListDataEmpty extends GetAllListState {}

class GetAllListDataError extends GetAllListState {}

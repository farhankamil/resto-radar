import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/remote_datasources/restaurants_datasources.dart';
import '../../../data/models/restaurant_detail_model.dart';

part 'detail_restaurant_event.dart';
part 'detail_restaurant_state.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  final ApiService apiservice;

  DetailRestaurantBloc(
    this.apiservice,
  ) : super(DetailRestaurantInitial()) {
    on<GetDetailEvent>((event, emit) async {
      try {
        emit(DetailRestaurantLoading());
        final result = await apiservice.getRestaurantDetail(event.id);
        emit(DetailRestaurantLoaded(detailModel: result));
      } catch (error) {
        emit(DetailRestaurantError());
      }
    });
  }
}

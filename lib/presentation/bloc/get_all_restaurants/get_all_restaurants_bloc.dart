import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:resto_radar/data/models/restaurant_list_model.dart';

import '../../../data/datasources/remote_datasources/restaurants_datasources.dart';

part 'get_all_restaurants_event.dart';
part 'get_all_restaurants_state.dart';

class GetAllRestaurantsBloc
    extends Bloc<GetAllRestaurantsEvent, GetAllListState> {
  final ApiService apiservice;
  GetAllRestaurantsBloc(
    this.apiservice,
  ) : super(GetAllListInitial()) {
    on<GetAllRestaurantsEvent>(
      (event, emit) async {
        try {
          emit(GetAllListLoading());
          final result = await apiservice.getRestaurantList();
          if (result.restaurants.isEmpty) {
            emit(GetAllListDataEmpty());
          } else {
            emit(GetAllListLoaded(listModel: result));
          }
        } catch (error) {
          emit(GetAllListDataError());
        }
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/remote_datasources/restaurants_datasources.dart';
import '../../../data/models/restaurant_search_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiservice;
  SearchBloc(
    this.apiservice,
  ) : super(GetAllRestaurantsInitial()) {
    on<GetAllSearchEvent>((event, emit) async {
      try {
        emit(GetAllRestaurantsLoading());
        final result = await apiservice.getRestaurantSearch(event.query);
        if (result.restaurants.isEmpty) {
          emit(GetAllRestaurantsDataEmpty());
        } else {
          emit(GetAllRestaurantsLoaded(searchlistModel: result));
        }
      } catch (error) {
        emit(GetAllRestaurantsError());
      }
    });
  }
}

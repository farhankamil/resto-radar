import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constans.dart';
import '../bloc/search_restaurants/search_bloc.dart';
import '../widgets/error_message.dart';
import '../widgets/restaurant_card.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<void> _reloadData() async {
    context.read<SearchBloc>().add(GetAllSearchEvent(query: query));
  }

  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Pencarian'),
        backgroundColor: backgroundColor1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    hintText: 'Cari nama restoran',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (newQuery) {
                    if (newQuery != query) {
                      setState(
                        () {
                          query = newQuery;
                        },
                      );

                      if (query.isNotEmpty) {
                        context
                            .read<SearchBloc>()
                            .add(GetAllSearchEvent(query: query));
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return _buildSearchView(state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchView(SearchState state) {
    if (query.isEmpty) {
      return const ErrorMessage(
        image: 'assets/folder_empty.png',
        message: 'silahkan lakukan pencarian',
      );
    } else {
      switch (state.runtimeType) {
        case GetAllRestaurantsLoading:
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        case GetAllRestaurantsLoaded:
          return Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return RestaurantCardKiri(
                    restaurant: (state).searchlistModel.restaurants[index],
                  );
                } else {
                  return RestaurantCardKanan(
                    (state).searchlistModel.restaurants[index],
                  );
                }
              },
              itemCount: (state as GetAllRestaurantsLoaded)
                  .searchlistModel
                  .restaurants
                  .length,
            ),
          );
        case GetAllRestaurantsDataEmpty:
          return const ErrorMessage(
            image: 'assets/folder_empty.png',
            message: 'Data Empty',
          );
        case GetAllRestaurantsError:
          return ErrorMessage(
            image: 'assets/dinosaur.png',
            message: 'No Connection',
            onPressed: _reloadData,
          );

        default:
          return const SizedBox();
      }
    }
  }
}

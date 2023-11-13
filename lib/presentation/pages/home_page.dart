import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resto_radar/presentation/pages/search_page.dart';
import 'package:resto_radar/presentation/widgets/restaurant_card.dart';

import '../../common/constans.dart';
import '../bloc/get_all_restaurants/get_all_restaurants_bloc.dart';
import '../widgets/error_message.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<GetAllRestaurantsBloc>().add(GetAllEvent());

    super.initState();
  }

  Future<void> _reloadData() async {
    context.read<GetAllRestaurantsBloc>().add(GetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        title: const Text('Resto Radar'),
        backgroundColor: backgroundColor1,
        actions: [
          IconButton(
            onPressed: () {
              context.push(
                SearchPage.routeName,
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GetAllRestaurantsBloc, GetAllListState>(
          builder: (context, state) {
            return _buildListView(state);
          },
        ),
      ),
    );
  }

  Widget _buildListView(GetAllListState state) {
    switch (state.runtimeType) {
      case GetAllListLoading:
        return Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      case GetAllListLoaded:
        return ListView.builder(
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return RestaurantCardKiri(
                restaurant: (state).listModel.restaurants[index],
              );
            } else {
              return RestaurantCardKanan(
                (state).listModel.restaurants[index],
              );
            }
          },
          itemCount: (state as GetAllListLoaded).listModel.restaurants.length,
        );
      case GetAllListDataEmpty:
        return const ErrorMessage(
          image: 'assets/folder_empty.png',
          message: 'Data Empty',
        );
      case GetAllListDataError:
        return ErrorMessage(
          image: 'assets/folder_empty.png',
          message: 'No Connection',
          onPressed: _reloadData,
        );
      default:
        return const SizedBox();
    }
  }
}

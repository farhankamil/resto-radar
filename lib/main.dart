import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'data/datasources/remote_datasources/restaurants_datasources.dart';
import 'presentation/bloc/detail_restaurants/detail_restaurant_bloc.dart';
import 'presentation/bloc/get_all_restaurants/get_all_restaurants_bloc.dart';
import 'presentation/bloc/search_restaurants/search_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/restaurant_detail_page.dart';
import 'presentation/pages/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '${DetailRestaurantPage.routeName}/:restaurantId',
        builder: (context, state) =>
            DetailRestaurantPage(id: state.pathParameters['restaurantId']!),
      ),
      GoRoute(
        path: SearchPage.routeName,
        builder: (context, state) => const SearchPage(),
      ),
    ],
    initialLocation: HomePage.routeName,
    debugLogDiagnostics: true,
    routerNeglect: true,
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetAllRestaurantsBloc(ApiService()),
        ),
        BlocProvider(
          create: (context) => DetailRestaurantBloc(ApiService()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ApiService()),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

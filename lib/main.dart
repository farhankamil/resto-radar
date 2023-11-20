import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:resto_radar/data/preferences/preferences_helper.dart';
import 'package:resto_radar/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:resto_radar/presentation/bloc/preferences/preferences_bloc.dart';
import 'package:resto_radar/presentation/bloc/scheduling/scheduling_bloc.dart';
import 'package:resto_radar/presentation/pages/main_navigation.dart';
import 'package:resto_radar/utils/background_service.dart';
import 'package:resto_radar/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/remote_datasources/restaurants_datasources.dart';
import 'presentation/bloc/detail_restaurants/detail_restaurant_bloc.dart';
import 'presentation/bloc/get_all_restaurants/get_all_restaurants_bloc.dart';
import 'presentation/bloc/search_restaurants/search_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/restaurant_detail_page.dart';
import 'presentation/pages/search_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: MainNavigation.routeName,
        builder: (context, state) => const MainNavigation(),
      ),
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
    initialLocation: MainNavigation.routeName,
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
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => SchedulingBloc(),
        ),
        BlocProvider(
          create: (context) => PreferencesBloc(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
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

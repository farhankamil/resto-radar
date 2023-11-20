import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_radar/presentation/pages/favorite_page.dart';
import 'package:resto_radar/presentation/pages/home_page.dart';
import 'package:resto_radar/presentation/pages/setting_page.dart';

import '../bloc/navigation/navigation_bloc.dart';

class MainNavigation extends StatelessWidget {
  static const routeName = '/LandingPage';
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems =
        const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '',
      ),
    ];

    const List<Widget> bottomNavScreen = <Widget>[
      HomePage(),
      FavoritePage(),
      SettingPage(),
    ];

    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              BlocProvider.of<NavigationBloc>(context)
                  .add(SelectTab(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}

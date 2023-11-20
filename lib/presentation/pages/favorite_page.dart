// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:resto_radar/data/models/restaurant_list_model.dart';
// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<FavoritePage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<FavoriteListBloc>().add(FavoriteListGetEvent());
//   }

//   @override
//   void didPopNext() {
//     context.read<FavoriteListBloc>().add(FavoriteListGetEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Watchlist'),
//       ),
//       body: SingleChildScrollView(
//         physics: const ScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Movie',
//               ),
//               const SizedBox(height: 8.0),
//               BlocBuilder(builder: (context, state) {
//                 if (state is FavoriteListLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (state is FavoriteListLoaded) {
//                   return Column(
//                     children: [
//                       state.restaurantList.isEmpty
//                           ? const Text('Empty')
//                           : ListView.builder(itemBuilder: (context, index) {
//                               final restaurant = state.restaurantList[index];
//                               return RestaurantCardKanan(restaurant as Restaurant);
//                             })
//                     ],
//                   );
//                 }
//                   if (state is FavoriteListError) {
//                     return Center(
//                       key: const Key('error_message'),
//                       child: Text(state.message),
//                     );
//                   }
//                 return const Text('no data');
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.amber,
      ),
    );
  }
}

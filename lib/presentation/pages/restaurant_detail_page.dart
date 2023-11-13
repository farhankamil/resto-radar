import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../common/constans.dart';
import '../../data/datasources/local_datasources/local_storage.dart';
import '../bloc/detail_restaurants/detail_restaurant_bloc.dart';
import '../widgets/error_message.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail';
  const DetailRestaurantPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  void initState() {
    context.read<DetailRestaurantBloc>().add(GetDetailEvent(id: widget.id));
    super.initState();
  }

  Future<void> _reloadData() async {
    context.read<DetailRestaurantBloc>().add(
          GetDetailEvent(id: widget.id),
        );
  }

  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: BlocConsumer<DetailRestaurantBloc, DetailRestaurantState>(
        listener: (context, state) async {
          if (state is DetailRestaurantLoaded) {
            await AuthLocalDatasource().saveAuthData(
              state.detailModel.restaurant,
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case DetailRestaurantLoading:
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            case DetailRestaurantLoaded:
              return Stack(
                children: [
                  _imageContent(context, state),
                  _buttonBack(context, state),
                  _detailContent(context, state),
                ],
              );
            case DetailRestaurantError:
              return ErrorMessage(
                image: 'assets/folder_empty.png',
                message: 'No Connection',
                onPressed: _reloadData,
              );

            default:
              return Image.asset(
                'assets/dinosaur.png',
                width: 50,
              );
          }
        },
      ),
    );
  }

  Widget _imageContent(context, state) {
    final heightImage = MediaQuery.of(context).size.height * 0.6;
    final widthImage = MediaQuery.of(context).size.width;
    return Container(
      height: heightImage,
      width: widthImage,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://restaurant-api.dicoding.dev/images/large/${state.detailModel.restaurant.pictureId}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buttonBack(context, state) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50.0,
        left: 25.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: secondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailContent(context, state) {
    final widthImage = MediaQuery.of(context).size.width;
    final categories = state.detailModel.restaurant.categories;
    final menus = state.detailModel.restaurant.menus.foods;
    final drinks = state.detailModel.restaurant.menus.drinks;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 1.0,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          width: widthImage,
          decoration: BoxDecoration(
            color: backgroundColor1,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    state.detailModel.restaurant.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 25,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBarIndicator(
                        rating: state.detailModel.restaurant.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        unratedColor: backgroundColor6,
                        itemSize: 18,
                      ),
                      Text(
                        ' | ${state.detailModel.restaurant.rating}',
                        style: primaryTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 23,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        state.detailModel.restaurant.city,
                        style: primaryTextStyle.copyWith(
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.detailModel.restaurant.description,
                    style: primaryTextStyle,
                    textAlign: TextAlign.justify,
                    maxLines: readMore ? 50 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        readMore = !readMore;
                      });
                    },
                    child: Text(
                      readMore ? "Read less" : "Read more",
                      style: purpleTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Categories:",
                    style: primaryTextStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      for (var category in categories)
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Text(
                              category.name,
                              style: primaryTextStyle.copyWith(
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Makanan:", style: primaryTextStyle),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var menu in menus)
                          Container(
                            width: 120,
                            margin: const EdgeInsets.only(
                              right: 6,
                              left: 6,
                              top: 15,
                              bottom: 15,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/ic_food.png',
                                  fit: BoxFit.contain,
                                  height: 80,
                                  width: 60,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  menu.name,
                                  style: TextStyle(
                                    fontWeight: bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Minuman:",
                    style: primaryTextStyle,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var drink in drinks)
                          Container(
                            width: 120,
                            margin: const EdgeInsets.only(
                              right: 6,
                              left: 6,
                              top: 15,
                              bottom: 15,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/ic_juice.png',
                                  fit: BoxFit.contain,
                                  height: 80,
                                  width: 60,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  drink.name,
                                  style: TextStyle(
                                    fontWeight: bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

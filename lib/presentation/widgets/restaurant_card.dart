import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:resto_radar/common/constans.dart';
import 'package:resto_radar/data/models/restaurant_list_model.dart';

import '../pages/restaurant_detail_page.dart';

class RestaurantCardKiri extends StatelessWidget {
  const RestaurantCardKiri({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('${DetailRestaurantPage.routeName}/${restaurant.id}');
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 170,
                  top: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      restaurant.city ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          rating: restaurant.rating ?? 0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 18,
                        ),
                        Text(
                          ' | ${restaurant.rating}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF616161),
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 180,
                width: 150,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.broken_image,
                      size: 120,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCardKanan extends StatelessWidget {
  const RestaurantCardKanan(this.restaurant, {super.key});
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('${DetailRestaurantPage.routeName}/${restaurant.id}');
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 170,
                  bottom: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      restaurant.city ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          rating: restaurant.rating ?? 0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 18,
                        ),
                        Text(
                          ' | ${restaurant.rating}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: const Color(0xFF616161)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 180,
                width: 150,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Icon(
                      Icons.broken_image,
                      size: 120,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

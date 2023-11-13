import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../models/restaurant_detail_model.dart';
import '../../models/restaurant_list_model.dart';
import '../../models/restaurant_search_model.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';
  Future<RestaurantListModel> getRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<RestaurantDetailModel> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<RestaurantSearchResult> getRestaurantSearch(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/search?q=$query'),
    );
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }
}

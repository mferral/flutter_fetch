import 'package:flutter_fetch/models/Photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<List<dynamic>> fetchAlbum() async {
Future<List<Photo>> fetchAlbum() async {
  String apiUrl =
      'https://jsonplaceholder.typicode.com/photos?_start=0&_limit=20';

  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Photo.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load from API');
  }
}

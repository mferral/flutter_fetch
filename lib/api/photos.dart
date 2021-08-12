import 'package:flutter_fetch/models/Photo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

// Future<List<dynamic>> fetchAlbum() async {
Future<List<Photo>> fetchAlbum() async {
  await Future.delayed(Duration(seconds: 4));
  Random random = new Random();
  int randomNumber = random.nextInt(100);
  int ini = randomNumber;
  String apiUrl =
      'https://jsonplaceholder.typicode.com/photos?_start=$ini&_limit=20';
  print(apiUrl);
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => new Photo.fromJson(job)).toList();
  } else {
    throw Exception('Failed to load from API');
  }
}

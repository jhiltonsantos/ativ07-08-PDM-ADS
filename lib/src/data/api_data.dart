import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/album.dart';

String url = 'https://jsonplaceholder.typicode.com/albums/';

Future<Album> fetchAlbum(int album) async {
  final response = await http.get(Uri.parse(url + album.toString()));
  if (response.statusCode != 200) throw Exception('Falha ao carregar os albuns');
  return Album.fromJson(jsonDecode(response.body));
}

Future<List<Album>> fetchAllAlbum() async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) throw Exception('Nao Carregou');
  List listResponse = json.decode(response.body);
  final listAlbums = <Album>[];
  for (Map<String, dynamic> map in listResponse) {
    Album album = Album.fromJson(map);
    listAlbums.add(album);
  }
  return listAlbums;
}





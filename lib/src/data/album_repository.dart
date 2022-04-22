import 'dart:convert';

import 'package:album_app/src/models/album.dart';
import 'package:http/http.dart' as http;

String url = 'https://jsonplaceholder.typicode.com/albums';

class AlbumRepository {
  Future<Album> fetchAlbum(int album) async {
    final response = await http.get(Uri.parse('$url/$album'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar o album');
    }
    return Album.fromJson(jsonDecode(response.body));
  }

  Future<List<Album>> fetchAllAlbum() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Nao Carregou');
    }
    final List<dynamic> listResponse = jsonDecode(response.body);
    final List<Album> albums =
        listResponse.map((dynamic json) => Album.fromJson(json)).toList();
    return albums;
  }


}

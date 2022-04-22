import 'dart:convert';

import 'package:album_app/src/models/post.dart';
import 'package:http/http.dart' as http;

String url = 'https://jsonplaceholder.typicode.com/posts';

class PostRepository {
  Future<Post> fetchPost(int postId) async {
    final response = await http.get(Uri.parse('$url/$postId'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar o album');
    }
    return Post.fromJson(jsonDecode(response.body));
  }

  Future<List<dynamic>> fetchInit(int page) async {
    const limit = 25;
    final uri = Uri.parse('$url?_limit=$limit&_page=$page');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar os albuns');
    }
    return jsonDecode(response.body);
  }
}
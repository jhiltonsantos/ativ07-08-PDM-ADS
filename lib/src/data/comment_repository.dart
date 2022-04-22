import 'dart:convert';

import 'package:album_app/src/models/comment.dart';
import 'package:http/http.dart' as http;

String url = 'https://jsonplaceholder.typicode.com/comments';

class CommentRepository {
  Future<List<Comment>> fetchAllCommentsById(int id) async {
    String urlComment =
        '$url?postId=$id';
    final response = await http.get(Uri.parse(urlComment));
    if (response.statusCode != 200) {
      throw Exception('Nao Carregou');
    }
    final List<dynamic> listResponse = jsonDecode(response.body);
    final List<Comment> comments =
    listResponse.map((dynamic json) => Comment.fromJson(json)).toList();
    return comments;
  }
}
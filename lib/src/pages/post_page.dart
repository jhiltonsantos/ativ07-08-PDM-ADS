import 'package:album_app/src/data/comment_repository.dart';
import 'package:album_app/src/data/post_repository.dart';
import 'package:album_app/src/models/comment.dart';
import 'package:album_app/src/models/post.dart';
import 'package:flutter/material.dart';


class PostPage extends StatefulWidget {
  final int id;
  const PostPage({Key? key, required this.id}) : super(key: key);
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final CommentRepository _commentRepository = CommentRepository();
  final PostRepository _postRepository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.id}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _postRepository.fetchPost(widget.id),
              builder: (context, AsyncSnapshot<Post> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error na requisição'));
                }
                if (snapshot.hasData) {
                  String idText =
                      snapshot.data?.id.toString() ?? 'Post Desconhecido';
                  String titleText =
                      snapshot.data?.title ?? 'Titulo Desconhecido';
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildCardText('Post: $idText'),
                      buildCardText('Título: $titleText'),
                      buildCardText('Comentários:'),
                    ],
                  );
                } else {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FutureBuilder<List<Comment>>(
                  future: _commentRepository.fetchAllCommentsById(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error na requisição'));
                    }
                    if (snapshot.hasData) {
                      final List<Comment>? comments = snapshot.data;
                      return SingleChildScrollView(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: comments!.length,
                            itemBuilder: (context, index) {
                              final Comment comment = comments[index];
                              return SingleChildScrollView(
                                child: Card(
                                  elevation: 3,
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(comment.body!),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Text(
                                        comment.email!,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCardText(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

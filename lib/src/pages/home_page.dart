import 'package:album_app/src/data/post_repository.dart';
import 'package:album_app/src/pages/post_page.dart';
import 'package:flutter/material.dart';

import '../models/album.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Album album;
  List<String> albumList = [];
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;

  final PostRepository _postRepository = PostRepository();

  @override
  void initState() {
    super.initState();

    fetch();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 1;
      albumList.clear();
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Posts'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: albumList.length + 1,
            itemBuilder: (context, int index) {
              //int? idAlbum = albumList[index].id ?? 0;
              if (index < albumList.length) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostPage(id: index + 1)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 8.0),
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            albumList[index].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: hasMore
                      ? const Center(child: CircularProgressIndicator())
                      : const Center(
                          child: Text(
                          'Não possui mais posts',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                );
              }
            }),
      ),
    );
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    List newAlbum = await _postRepository.fetchInit(page);
    setState(() {
      page++;
      isLoading = false;
      if (newAlbum.length < 25) {
        hasMore = false;
      }
      albumList.addAll(newAlbum.map<String>((item) {
        final number = item['id'];
        return 'Post $number';
      }).toList());
    });
  }
}

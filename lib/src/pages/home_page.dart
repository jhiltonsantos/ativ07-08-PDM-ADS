import 'package:album_app/src/data/api_data.dart';
import 'package:album_app/src/pages/album_page.dart';
import 'package:flutter/material.dart';

import '../models/album.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Album album;
  List<Album> futureAlbumsList = [];
  final ScrollController _scrollController = ScrollController();
  late int index;

  @override
  void initState() {
    super.initState();
    fetchMoreAlbums(0);
    scrollInfinite();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Albuns'),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: futureAlbumsList.length,
          itemBuilder: (context, int index) {
            int? idAlbum = futureAlbumsList[index].id ?? 0;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlbumPage(id: idAlbum)));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        idAlbum.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  fetch(int index) async {
    album = await fetchAlbum(index);
    futureAlbumsList.add(album);
    setState(() {});
  }

  fetchMoreAlbums(int value) async {
    for (int i = 0; i < 20; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      fetch(value);
      value++;
    }
    index = value;
    print(index);
  }

  scrollInfinite() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMoreAlbums(index);
      }
    });
  }
}

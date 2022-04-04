import 'package:flutter/material.dart';

import '../data/api_data.dart';
import '../models/album.dart';

class AlbumPage extends StatefulWidget {
  final int id;

  const AlbumPage({Key? key, required this.id}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album ${widget.id}'),
      ),
      body: FutureBuilder(
        future: futureAlbum,
        builder: (context, AsyncSnapshot<Album> snapshot) {
          if (snapshot.hasData) {
            String idText =
                snapshot.data?.id.toString() ?? 'Album Desconhecido';
            String titleText = snapshot.data?.title ?? 'Titulo Desconhecido';
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                buildCardText('Album: $idText'),
                buildCardText('Título: $titleText'),
              ],
            );
          }
          return Text('${widget.id}');
        },
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
        style:
            const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

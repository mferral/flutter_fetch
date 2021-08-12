import 'package:flutter/material.dart';
import 'package:flutter_fetch/api/photos.dart';
import 'package:flutter_fetch/models/Photo.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PhotosListView extends StatefulWidget {
  // const PhotosListView({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PhotosListView> {
  late bool eneableShimmer;
  late Future<List<Photo>> futureAlbum;
  late List<Photo> album;

  @override
  void initState() {
    super.initState();
    eneableShimmer = false;
    album = [];
    // futureAlbum = fetchAlbum();
  }

  Future<void> _refreshList() async {
    setState(() {
      eneableShimmer = true;
    });
    album = await fetchAlbum();
    eneableShimmer = false;
    setState(() {});
  }

  Future<List<Photo>> _getAlbum() async {
    if (album.length == 0) {
      album = await fetchAlbum();
    }
    return album;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => _refreshList(),
        child: FutureBuilder<List<Photo>>(
            future: _getAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Photo>? data = snapshot.data;
                return _listView(data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            }));
  }

  Shimmer _listView(data) {
    return Shimmer(
        colorOpacity: 0.8,
        enabled: eneableShimmer,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _tile(data[index].title, data[index].id.toString(),
                  data[index].thumbnailUrl);
            }));
  }

  ListTile _tile(String title, String subtitle, String icon) => ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
          )),
      subtitle: Text(subtitle),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(icon),
      ),
      enabled: !eneableShimmer,
      onTap: () => print("ListTile"));
}

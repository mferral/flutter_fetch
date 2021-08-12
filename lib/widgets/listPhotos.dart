import 'package:flutter/material.dart';
import 'package:flutter_fetch/api/photos.dart';
import 'package:flutter_fetch/models/Photo.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class PhotosListView extends StatefulWidget {
  // const PhotosListView({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PhotosListView> {
  late Future<List<Photo>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Future<void> _refreshList() async {
    setState(() {
      futureAlbum = fetchAlbum();
    });
  }

  @override
  Widget build(BuildContext context) {
    // LiquidPullToRefresh
    return RefreshIndicator(
        onRefresh: () => _refreshList(),
        child: FutureBuilder<List<Photo>>(
            future: futureAlbum,
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
}

ListView _listView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _tile(data[index].title, data[index].id.toString(),
            data[index].thumbnailUrl);
      });
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
    );

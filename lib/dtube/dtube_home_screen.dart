import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/dtube/dtube_loaded_video_item.dart';
import 'package:mobile_app/dtube/dtube_video_details_screen.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';

class DTubeHomeScreen extends StatefulWidget {
  const DTubeHomeScreen({
    Key? key,
    required this.title,
    required this.path,
  }) : super(key: key);
  final String title;
  final String path;

  @override
  State<DTubeHomeScreen> createState() => _DTubeHomeScreenState();
}

class _DTubeHomeScreenState extends State<DTubeHomeScreen> {
  Future<List<NewVideosResponseModelItem>> loadNewVideos() async {
    var uri = Uri.parse('https://avalon.d.tube/${widget.path}');
    var request = http.Request('GET', uri);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseValue = await response.stream.bytesToString();
      List<NewVideosResponseModelItem> items =
          decodeStringOfVideos(responseValue);
      return items;
    } else {
      log(response.reasonPhrase ?? 'Status code not 200');
      throw response.reasonPhrase ?? 'Status code not 200';
    }
  }

  Widget listOfVideoTiles(List<NewVideosResponseModelItem> list) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return DTubeLoadedVideoItem(
            item: list[index],
            onTap: () {
              var screen = VideoDetailsScreen(item: list[index]);
              var route = MaterialPageRoute(builder: (c) => screen);
              Navigator.of(context).push(route);
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 0);
      },
      itemCount: list.length,
    );
  }

  Widget loadingIndicator() {
    return Center(
      child: Column(
        children: const [
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text('Loading Data'),
          Spacer(),
        ],
      ),
    );
  }

  Widget body() {
    return FutureBuilder(
      future: loadNewVideos(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
              'An Error occured. ${snapshot.error?.toString() ?? 'Unknown Error'}');
        } else if (snapshot.hasData) {
          return listOfVideoTiles(
              snapshot.data as List<NewVideosResponseModelItem>);
        } else {
          return loadingIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: body(),
    );
  }
}

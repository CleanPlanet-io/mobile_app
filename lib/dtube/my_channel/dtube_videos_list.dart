import 'package:flutter/material.dart';
import 'package:mobile_app/dtube/dtube_loaded_video_item.dart';
import 'package:mobile_app/dtube/dtube_video_details_screen.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';

class VideosList extends StatefulWidget {
  const VideosList({Key? key, required this.list}) : super(key: key);
  final List<NewVideosResponseModelItem> list;

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  Widget listOfVideoTiles(List<NewVideosResponseModelItem> list) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return DTubeLoadedVideoItem(
          item: list[index],
          onTap: () {
            var screen = VideoDetailsScreen(item: list[index]);
            var route = MaterialPageRoute(builder: (c) => screen);
            Navigator.of(context).push(route);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return listOfVideoTiles(widget.list);
  }
}

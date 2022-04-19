import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/dtube/dtube_loaded_video_item.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';

class DTubeVideoItem extends StatefulWidget {
  const DTubeVideoItem({
    Key? key,
    required this.path,
    required this.item,
    required this.result,
  }) : super(key: key);
  final String path;
  final NewVideosResponseModelItem? item;
  final Function(String, NewVideosResponseModelItem) result;

  @override
  State<DTubeVideoItem> createState() => _DTubeVideoItemState();
}

class _DTubeVideoItemState extends State<DTubeVideoItem> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var uri = Uri.parse('https://avalon.d.tube/content/${widget.path}');
    var request = http.Request('GET', uri);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseValue = await response.stream.bytesToString();
      NewVideosResponseModelItem data =
          NewVideosResponseModelItem.fromJsonString(responseValue);
      widget.result(widget.path, data);
    } else {
      log(response.reasonPhrase ?? 'Status code not 200');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      return DTubeLoadedVideoItem(
          item: widget.item!,
          onTap: () {
            // to-do - do navigation here.
          });
    } else {
      return ListTile(
        leading: const CircularProgressIndicator(),
        title: Text(widget.path),
      );
    }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/dtube/dtube_vide_details_screen.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  String getVideoThumbnailUrl(NewVideosResponseModelItem item) {
    if (item.jsonObject.thumbnailUrl.isNotEmpty) {
      return item.jsonObject.thumbnailUrl;
    } else if (item.jsonObject.thumbnailUrlExternal.isNotEmpty) {
      return item.jsonObject.thumbnailUrlExternal;
    } else if (item.jsonObject.files.youtube.isNotEmpty) {
      return "https://img.youtube.com/vi/${item.jsonObject.files.youtube}/0.jpg";
    } else {
      return "";
    }
  }

  Widget titleAndSubtitle(String title, String subtitle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              // responseItems[index].jsonObject.title,
              style: Theme.of(context).textTheme.bodyText1),
          Text(subtitle,
              //'${responseItems[index].author}, DTC ${responseItems[index].dist}, ${responseItems[index].jsonObject.tag}',
              style: Theme.of(context).textTheme.bodyText2)
        ],
      ),
    );
  }

  Widget videoInfo(NewVideosResponseModelItem item) {
    var upvotes = item.votes.where((element) => element.vt > 0).length - 1;
    var dowvotes = item.votes.where((element) => element.vt < 0).length;
    var dateTime = timeago.format(DateTime.fromMillisecondsSinceEpoch(item.ts));
    var dtcValue = item.dist / 100.0;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: Image.network(
                    'https://avalon.d.tube/image/avatar/${item.author}/small')
                .image,
          ),
          const SizedBox(width: 5),
          titleAndSubtitle(
            item.jsonObject.title,
            '${item.author}, DTC ${dtcValue.toStringAsFixed(2)} $dateTime ${upvotes > 0 ? '👍 $upvotes' : ''} ${dowvotes > 0 ? '👎 $dowvotes' : ''}',
          )
        ],
      ),
    );
  }

  Widget videoThumbnail(NewVideosResponseModelItem item) {
    return Stack(children: [
      SizedBox(
        height: 240,
        width: MediaQuery.of(context).size.width,
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/not_found_thumb.png',
          image: getVideoThumbnailUrl(item),
          imageErrorBuilder: (context, error, trace) {
            return Image.asset('assets/not_found_thumb.png');
          },
          fit: BoxFit.fitWidth,
        ),
      ),
      Row(
        children: [
          const Spacer(),
          Image.asset(item.jsonObject.files.youtube.isEmpty
              ? 'assets/ipfs.png'
              : 'assets/yt.png'),
          const SizedBox(
            width: 5,
          )
        ],
      )
    ]);
  }

  Widget videoListTile(NewVideosResponseModelItem item) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        children: [videoThumbnail(item), videoInfo(item)],
      ),
      onTap: () {
        var screen = VideoDetailsScreen(item: item);
        var route = MaterialPageRoute(builder: (c) => screen);
        Navigator.of(context).push(route);
      },
    );
  }

  Widget listOfVideoTiles(List<NewVideosResponseModelItem> list) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return videoListTile(list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 0);
        },
        itemCount: list.length);
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

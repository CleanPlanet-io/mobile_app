import 'package:flutter/material.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';
import 'package:timeago/timeago.dart' as timeago;

class DTubeLoadedVideoItem extends StatefulWidget {
  const DTubeLoadedVideoItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);
  final NewVideosResponseModelItem item;
  final Function onTap;

  @override
  State<DTubeLoadedVideoItem> createState() => _DTubeLoadedVideoItemState();
}

class _DTubeLoadedVideoItemState extends State<DTubeLoadedVideoItem> {
  String getVideoThumbnailUrl() {
    if (widget.item.jsonObject.thumbnailUrl.isNotEmpty) {
      return widget.item.jsonObject.thumbnailUrl;
    } else if (widget.item.jsonObject.thumbnailUrlExternal.isNotEmpty) {
      return widget.item.jsonObject.thumbnailUrlExternal;
    } else if (widget.item.jsonObject.files.youtube.isNotEmpty) {
      return "https://img.youtube.com/vi/${widget.item.jsonObject.files.youtube}/0.jpg";
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

  Widget videoInfo() {
    var upvotes =
        widget.item.votes.where((element) => element.vt > 0).length - 1;
    var dowvotes = widget.item.votes.where((element) => element.vt < 0).length;
    var dateTime =
        timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.item.ts));
    var dtcValue = widget.item.dist / 100.0;
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: Image.network(
                    'https://avalon.d.tube/image/avatar/${widget.item.author}/small')
                .image,
          ),
          const SizedBox(width: 5),
          titleAndSubtitle(
            widget.item.jsonObject.title,
            '${widget.item.author}, DTC ${dtcValue.toStringAsFixed(2)} $dateTime ${upvotes > 0 ? '👍 $upvotes' : ''} ${dowvotes > 0 ? '👎 $dowvotes' : ''}',
          )
        ],
      ),
    );
  }

  Widget videoThumbnail() {
    return Stack(children: [
      SizedBox(
        height: 240,
        width: MediaQuery.of(context).size.width,
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/not_found_thumb.png',
          image: getVideoThumbnailUrl(),
          imageErrorBuilder: (context, error, trace) {
            return Image.asset('assets/not_found_thumb.png');
          },
          fit: BoxFit.fitWidth,
        ),
      ),
      Row(
        children: [
          const Spacer(),
          Image.asset(widget.item.jsonObject.files.youtube.isEmpty
              ? 'assets/ipfs.png'
              : 'assets/yt.png'),
          const SizedBox(
            width: 5,
          )
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        children: [
          videoThumbnail(),
          videoInfo(),
        ],
      ),
      onTap: () {
        widget.onTap();
      },
    );
  }
}

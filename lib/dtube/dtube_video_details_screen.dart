import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({Key? key, required this.item}) : super(key: key);
  // final String videoId;
  final NewVideosResponseModelItem item;

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late YoutubePlayerController _controller;
  late String? _videoUrl;

  late List<NewVideosResponseModelItemVotesItem> votes;
  bool doWeHaveVotesInfo = false;

  @override
  void initState() {
    super.initState();
    if (widget.item.jsonObject.files.youtube.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.item.jsonObject.files.youtube,
        params: const YoutubePlayerParams(
          autoPlay: true,
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    } else if (widget.item.jsonObject.files.ipfs?.vid.src != null) {
      var gateway =
          widget.item.jsonObject.files.ipfs?.gw ?? 'https://player.d.tube';
      _videoUrl = '$gateway/ipfs/${widget.item.jsonObject.files.ipfs!.vid.src}';
    }
    loadVoteInfo();
  }

  Future<void> loadVoteInfo() async {
    var request = http.Request(
        'GET', Uri.parse('https://avalon.d.tube/content/${widget.item.id}'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseValue = await response.stream.bytesToString();
      NewVideosResponseModelItem item =
          NewVideosResponseModelItem.fromJsonString(responseValue);
      setState(() {
        votes = item.votes;
        doWeHaveVotesInfo = true;
      });
    } else {
      log(response.reasonPhrase ?? 'Status code not 200');
      throw response.reasonPhrase ?? 'Status code not 200';
    }
  }

  Widget _player() {
    return (widget.item.jsonObject.files.youtube.isNotEmpty)
        ? YoutubePlayerIFrame(
            controller: _controller,
            aspectRatio: 16 / 9,
          )
        : (_videoUrl != null)
            ? BetterPlayer.network(
                _videoUrl!,
                betterPlayerConfiguration: const BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                ),
              )
            : Container();
  }

  Widget votesList(List<NewVideosResponseModelItemVotesItem> votes) {
    if (votes.isEmpty) {
      return const Center(
        child: Text('Nothing to show.'),
      );
    }
    votes.sort((a, b) => a.vt > b.vt
        ? -1
        : a.vt < b.vt
            ? 1
            : 0);
    var formatter = NumberFormat.compact();
    return Container(
      margin: const EdgeInsets.only(top: 55),
      child: ListView.separated(
        itemBuilder: (c, i) {
          var dateTime =
              timeago.format(DateTime.fromMillisecondsSinceEpoch(votes[i].ts));
          return ListTile(
            contentPadding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
            leading: CircleAvatar(
              backgroundImage: Image.network(
                      'https://avalon.d.tube/image/avatar/${votes[i].u}/small')
                  .image,
            ),
            title:
                Text(votes[i].u, style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text('${formatter.format(votes[i].vt)} votes\n$dateTime'),
            trailing: Text(
              '${(votes[i].claimable / 100.0).toStringAsFixed(2)} DTC',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
        separatorBuilder: (c, i) => const Divider(height: 0),
        itemCount: votes.length,
      ),
    );
  }

  void showDownVotes() {
    var downVotes = votes.where((element) => element.vt <= 0).toList();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Stack(
            children: [
              SizedBox(
                height: 55,
                child: AppBar(
                  title: const Text('Down voted by following users'),
                ),
              ),
              votesList(downVotes),
            ],
          ),
        );
      },
    );
  }

  void showUpVotes() {
    var upVotes = votes.where((element) => element.vt > 0).toList();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Stack(
            children: [
              SizedBox(
                height: 55,
                child: AppBar(
                  title: const Text('Up voted by following users'),
                ),
              ),
              votesList(upVotes),
            ],
          ),
        );
      },
    );
  }

  Widget _author() {
    return InkWell(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: Image.network(
                    'https://avalon.d.tube/image/avatar/${widget.item.author}/small')
                .image,
          ),
          const SizedBox(width: 5),
          Text(widget.item.author,
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
      onTap: () {},
    );
  }

  Widget _videoAuthorInfo() {
    var upvotes =
        widget.item.votes.where((element) => element.vt > 0).length - 1;
    var dowvotes = widget.item.votes.where((element) => element.vt < 0).length;
    var upVoteButton = upvotes > 0
        ? Badge(
            badgeContent: Text('$upvotes'),
            position: const BadgePosition(top: -15, end: -15),
            child: const Icon(Icons.thumb_up_sharp),
          )
        : const Icon(Icons.thumb_up_sharp);
    var downVoteButton = dowvotes > 0
        ? Badge(
            badgeContent: Text('$dowvotes'),
            position: const BadgePosition(top: -15, end: -15),
            child: const Icon(Icons.thumb_down_sharp),
          )
        : const Icon(Icons.thumb_down_sharp);
    var array = [
      _author(),
      const Spacer(),
      Text(
        '${(widget.item.dist / 100.0).toStringAsFixed(2)} DTC',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ];

    if (doWeHaveVotesInfo) {
      array += [
        IconButton(onPressed: showUpVotes, icon: upVoteButton),
        IconButton(onPressed: showDownVotes, icon: downVoteButton),
      ];
    }

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: array,
      ),
    );
  }

  Widget _videoTitle() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Text(widget.item.jsonObject.title,
          style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget _videoDescription() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: MarkdownBody(
        data: widget.item.jsonObject.desc,
        onTapLink: (text, href, title) async {
          if (href != null) {
            await launch(href);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.jsonObject.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _player(),
            _videoAuthorInfo(),
            _videoTitle(),
            _videoDescription(),
          ],
        ),
      ),
    );
  }
}

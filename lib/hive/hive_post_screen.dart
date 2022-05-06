import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile_app/models/hive/hive_posts.dart';
import 'package:url_launcher/url_launcher.dart';

class HivePostScreen extends StatefulWidget {
  const HivePostScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  final HivePostsResponseResultItem item;

  @override
  State<HivePostScreen> createState() => _HivePostScreenState();
}

class _HivePostScreenState extends State<HivePostScreen> {
  Widget _body() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Markdown(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        data: widget.item.body,
        onTapLink: (text, url, title) {
          launchUrl(Uri.parse(url ?? 'https://google.com'));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: _body(),
    );
  }
}

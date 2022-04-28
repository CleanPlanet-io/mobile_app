import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class HivePostScreen extends StatefulWidget {
  const HivePostScreen({Key? key, required this.markDown, required this.title})
      : super(key: key);
  final String markDown;
  final String title;

  @override
  State<HivePostScreen> createState() => _HivePostScreenState();
}

class _HivePostScreenState extends State<HivePostScreen> {
  Widget _body() {
    return Markdown(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      data: widget.markDown, //Utilities.removeAllHtmlTags(markDown),
      onTapLink: (text, url, title) {
        launchUrl(Uri.parse(url ?? 'https://google.com'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(),
    );
  }
}

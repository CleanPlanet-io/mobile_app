import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app_data/clean_planet_app_data.dart';
import 'package:mobile_app/dtube/my_channel/dtube_videos_list.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';
import 'package:provider/provider.dart';

class MyChannelScreen extends StatefulWidget {
  const MyChannelScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  State<MyChannelScreen> createState() => _MyChannelScreenState();
}

class _MyChannelScreenState extends State<MyChannelScreen> {
  Future<List<NewVideosResponseModelItem>> loadNewVideos() async {
    var request = http.Request(
        'GET', Uri.parse('https://avalon.d.tube/blog/${widget.title}'));
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
              'An Error occurred. ${snapshot.error?.toString() ?? 'Unknown Error'}');
        } else if (snapshot.hasData) {
          return VideosList(
            list: snapshot.data as List<NewVideosResponseModelItem>,
          );
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
        actions: [
          IconButton(
            onPressed: () async {
              const storage = FlutterSecureStorage();
              await storage.delete(key: 'dUsername');
              await storage.delete(key: 'dKey');
              var currentValue = Provider.of<CleanPlanetAppData>(context);
              var newValue = CleanPlanetAppData(
                dTubeUserData: null,
                hiveUserData: currentValue.hiveUserData,
              );
              CleanPlanetAppData.updateUserData(newValue);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: body(),
    );
  }
}

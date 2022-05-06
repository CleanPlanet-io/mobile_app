import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app_data/clean_planet_app_data.dart';
import 'package:mobile_app/drawer.dart';
import 'package:mobile_app/dtube/dtube_curated_video_item.dart';
import 'package:mobile_app/dtube/dtube_loaded_video_item.dart';
import 'package:mobile_app/dtube/dtube_video_details_screen.dart';
import 'package:mobile_app/dtube/login/dtube_login_screen.dart';
import 'package:mobile_app/dtube/my_channel/my_channel_screen.dart';
import 'package:mobile_app/models/history/dtube_history.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';
import 'package:provider/provider.dart';

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

class _DTubeHomeScreenState extends State<DTubeHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  static const List<Tab> myTabs = <Tab>[
    Tab(child: Text('Channel')),
    Tab(child: Text('Curated Videos')),
  ];

  bool hasMoreData = true;
  bool moreLoading = false;
  List<DTubeHistoryItemRecord> items = [];
  List<DTubeHistoryItemRecord> filteredItems = [];
  Map<String, NewVideosResponseModelItem> map = {};

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: myTabs.length, vsync: this);
    loadNextPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadNextPage() async {
    if (!hasMoreData) return;
    setState(() {
      moreLoading = true;
    });
    var uri = Uri.parse(
        'https://avalon.d.tube/history/cleanplanet/0/${items.length}');
    var request = http.Request('GET', uri);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseValue = await response.stream.bytesToString();
      List<DTubeHistoryItemRecord> items =
          decodeStringOfDTubeHistory(responseValue);
      setState(() {
        if (items.length < 50) {
          hasMoreData = false;
        }
        moreLoading = false;
        this.items += items;
        filteredItems += items.where((e) {
          if (e.txs.isEmpty) return false;
          return e.txs.first.type == 19;
        }).toList();
      });
    } else {
      setState(() {
        moreLoading = false;
      });
      log(response.reasonPhrase ?? 'Status code not 200');
    }
  }

  Widget _listView() {
    return ListView.separated(
      itemBuilder: (c, i) {
        if (i == filteredItems.length) {
          if (!hasMoreData) {
            return const ListTile(
              title: Text('End of Data'),
            );
          }
          if (moreLoading) {
            return const ListTile(
              title: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ListTile(
              title: Center(
                child: ElevatedButton(
                  onPressed: () {
                    loadNextPage();
                  },
                  child: const Text('Load More'),
                ),
              ),
            );
          }
        }
        var author = filteredItems[i].txs.first.data.author;
        var link = filteredItems[i].txs.first.data.link;
        var path = '$author/$link';
        return DTubeVideoItem(
          path: path,
          item: map[path],
          result: (path, item) {
            setState(() {
              map[path] = item;
            });
          },
        );
      },
      separatorBuilder: (c, i) => const Divider(),
      itemCount: filteredItems.length + 1,
    );
  }

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
          },
        );
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
    var appData = Provider.of<CleanPlanetAppData?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Planet - D.Tube'),
        bottom: TabBar(
          isScrollable: true,
          controller: _controller,
          tabs: myTabs,
        ),
        actions: [
          appData?.dTubeUserData == null
              ? IconButton(
                  onPressed: () {
                    var screen = const DTubeLoginScreen();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => screen));
                  },
                  icon: const Icon(Icons.login),
                )
              : IconButton(
                  onPressed: () {
                    var screen = MyChannelScreen(
                        title: appData!.dTubeUserData!.username);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (c) => screen));
                  },
                  icon: const Icon(Icons.person),
                )
        ],
      ),
      drawer: const DrawerMenu(),
      body: TabBarView(
        controller: _controller,
        children: [
          body(),
          _listView(),
        ],
      ),
    );
  }
}

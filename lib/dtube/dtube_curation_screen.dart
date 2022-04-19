import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/dtube/dtube_curated_video_item.dart';
import 'package:mobile_app/models/history/dtube_history.dart';
import 'package:mobile_app/models/new_videos_feed/new_videos_feed.dart';

class DTubeCurationScreen extends StatefulWidget {
  const DTubeCurationScreen({Key? key}) : super(key: key);

  @override
  State<DTubeCurationScreen> createState() => _DTubeCurationScreenState();
}

class _DTubeCurationScreenState extends State<DTubeCurationScreen> {
  bool hasMoreData = true;
  bool moreLoading = false;
  List<DTubeHistoryItemRecord> items = [];
  List<DTubeHistoryItemRecord> filteredItems = [];
  Map<String, NewVideosResponseModelItem> map = {};

  @override
  void initState() {
    super.initState();
    loadNextPage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curated Videos by CleanPlanet'),
      ),
      body: _listView(),
    );
  }
}

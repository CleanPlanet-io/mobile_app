import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/models/history/dtube_history.dart';

class DTubeCurationScreen extends StatefulWidget {
  const DTubeCurationScreen({Key? key}) : super(key: key);

  @override
  State<DTubeCurationScreen> createState() => _DTubeCurationScreenState();
}

class _DTubeCurationScreenState extends State<DTubeCurationScreen> {
  bool hasMoreData = true;
  bool moreLoading = false;
  List<DTubeHistoryItem> items = [];

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
      List<DTubeHistoryItem> items = decodeStringOfDTubeHistory(responseValue);
      setState(() {
        moreLoading = false;
        this.items += items;
      });
    } else {
      setState(() {
        moreLoading = false;
      });
      log(response.reasonPhrase ?? 'Status code not 200');
      throw response.reasonPhrase ?? 'Status code not 200';
    }
  }

  Widget _listView() {
    var filteredItems = items.where((e) => e.type == 19).toList();
    return ListView.separated(
      itemBuilder: (c, i) {
        if (i == filteredItems.length) {
          if (moreLoading) {
            return const ListTile(
              title: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ListTile(
              title: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Load More'),
                ),
              ),
            );
          }
        }
        return ListTile(
          title: Text(
              '${filteredItems[i].data.author}/${filteredItems[i].data.link}'),
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
        title: const Text('Cleaning Activities - Videos'),
      ),
      body: _listView(),
    );
  }
}

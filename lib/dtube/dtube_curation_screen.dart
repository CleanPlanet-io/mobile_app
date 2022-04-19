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
  List<DTubeHistoryItemRecord> items = [];
  List<DTubeHistoryItemRecord> filteredItems = [];

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
      throw response.reasonPhrase ?? 'Status code not 200';
    }
  }

  Widget _listView() {
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
                  onPressed: () {
                    loadNextPage();
                  },
                  child: const Text('Load More'),
                ),
              ),
            );
          }
        }
        return ListTile(
          title: Text(
              '${filteredItems[i].txs.first.data.author}/${filteredItems[i].txs.first.data.link}'),
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

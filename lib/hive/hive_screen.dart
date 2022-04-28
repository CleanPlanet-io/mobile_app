import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/drawer.dart';
import 'package:mobile_app/hive/hive_post_screen.dart';
import 'package:mobile_app/models/hive/hive_delegators_response.dart';
import 'package:mobile_app/models/hive/hive_finance_response.dart';
import 'package:mobile_app/models/hive/hive_posts.dart';

class HiveScreen extends StatefulWidget {
  const HiveScreen({Key? key}) : super(key: key);

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  static const List<Tab> myTabs = <Tab>[
    Tab(child: Text('Delegators')),
    Tab(child: Text('Posts')),
    Tab(child: Text('Curated Posts')),
  ];

  List<HiveDelegatorItem> items = [];
  List<HivePostsResponseResultItem> posts = [];
  var isLoadingDelegators = false;
  var isLoadingPosts = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: myTabs.length, vsync: this);
    loadDelegators();
    loadPosts();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadPosts() async {
    var request = http.Request('POST', Uri.parse('https://api.hive.blog/'));
    request.body = json.encode({
      "id": 8,
      "jsonrpc": "2.0",
      "method": "bridge.get_account_posts",
      "params": {"sort": "posts", "account": "cleanplanet", "observer": ""}
    });
    setState(() {
      isLoadingPosts = true;
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var string = await response.stream.bytesToString();
      var data = HivePostsResponse.fromJsonString(string);
      setState(() {
        isLoadingPosts = false;
        posts = data.result;
      });
    } else {
      _showError(response.reasonPhrase.toString());
      setState(() {
        isLoadingPosts = false;
        posts = [];
      });
    }
  }

  void loadDelegators() async {
    var uri =
        // Uri.parse('https://api.hive-keychain.com/hive/delegators/cleanplanet');
        Uri.parse(
            'https://ecency.com/private-api/received-vesting/cleanplanet');
    var request = http.Request('GET', uri);
    setState(() {
      isLoadingDelegators = true;
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseValue = await response.stream.bytesToString();
      var communitiesResponse =
          HiveDelegatorsResponseItem.fromJsonString(responseValue);
      var finRequest =
          http.Request('POST', Uri.parse('https://api.hive.blog/'));
      finRequest.body = json.encode({
        "id": 1,
        "jsonrpc": "2.0",
        "method": "condenser_api.get_dynamic_global_properties",
        "params": []
      });
      http.StreamedResponse responseFinance = await finRequest.send();

      if (responseFinance.statusCode == 200) {
        var responseFinanceValue = await responseFinance.stream.bytesToString();
        var finance = HiveFinanceResponse.fromJsonString(responseFinanceValue);
        var items = communitiesResponse.map((e) {
          var value = e.vestingShares *
              (finance.result.totalVestingFundHiveDouble /
                  finance.result.totalVestingSharesDouble);
          return HiveDelegatorItem(delegator: e.delegator, delegated: value);
        }).toList();
        items = items.where((e) => e.delegated > 0.01).toList();
        items.sort((a, b) => a.delegated < b.delegated
            ? 1
            : a.delegated > b.delegated
                ? -1
                : 0);
        setState(() {
          this.items = items;
          isLoadingDelegators = false;
        });
      } else {
        _showError("Status code is ${responseFinance.statusCode}");
        setState(() {
          items = [];
          isLoadingDelegators = false;
        });
      }
    } else {
      _showError("Status code is ${response.statusCode}");
      setState(() {
        items = [];
        isLoadingDelegators = false;
      });
    }
  }

  void _showError(String string) {
    var snackBar = SnackBar(content: Text('Error: $string'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  AppBar getAppBar() {
    return AppBar(
      title: Row(
        children: [
          SizedBox(
            child: Image.asset('assets/fullLogo.png'),
            height: 64,
            width: 64,
          ),
          const SizedBox(width: 10),
          const Text('CleanPlanet - Hive'),
        ],
      ),
      bottom: TabBar(
        isScrollable: true,
        controller: _controller,
        tabs: myTabs,
      ),
    );
  }

  Widget getBodyForDelegators(BuildContext context) {
    if (isLoadingDelegators) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (c, i) {
        return ListTile(
          leading: SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.hive.blog/u/${items[i].delegator}/avatar'),
              backgroundColor: Colors.transparent,
              radius: 100,
            ),
          ),
          title: Text(items[i].delegator),
          trailing: Text('${items[i].delegated.toStringAsFixed(3)} HP'),
        );
      },
      separatorBuilder: (c, i) => const Divider(height: 0),
      itemCount: items.length,
    );
  }

  Widget getBodyForPosts(BuildContext context) {
    if (isLoadingPosts) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (c, i) {
        var url = posts[i].jsonMetadata.image.isEmpty
            ? 'https://images.hive.blog/u/${posts[i].author}/avatar'
            : posts[i].jsonMetadata.image.first;
        return ListTile(
          leading: SizedBox(
            height: 100,
            width: 70,
            child: CircleAvatar(
              backgroundImage: NetworkImage(url),
              backgroundColor: Colors.transparent,
              radius: 100,
            ),
          ),
          title: Text(posts[i].title),
          subtitle: Text(posts[i].jsonMetadata.description),
          trailing: Text('\$ ${posts[i].payout.toStringAsFixed(3)}'),
          onTap: () {
            var screen = HivePostScreen(item: posts[i]);
            var route = MaterialPageRoute(builder: (c) => screen);
            Navigator.of(context).push(route);
          },
        );
      },
      separatorBuilder: (c, i) => const Divider(height: 0),
      itemCount: posts.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      drawer: const DrawerMenu(),
      body: TabBarView(
        controller: _controller,
        children: [
          getBodyForDelegators(context),
          getBodyForPosts(context),
          const Text('Curated'),
        ],
      ),
    );
  }
}

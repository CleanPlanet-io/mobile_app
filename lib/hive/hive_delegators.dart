import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/drawer.dart';
import 'package:mobile_app/models/hive/hive_delegators_response.dart';
import 'package:mobile_app/models/hive/hive_finance_response.dart';

class HiveDelegators extends StatefulWidget {
  const HiveDelegators({Key? key}) : super(key: key);

  @override
  State<HiveDelegators> createState() => _HiveDelegatorsState();
}

class _HiveDelegatorsState extends State<HiveDelegators> {
  List<HiveDelegatorItem> items = [];

  @override
  void initState() {
    super.initState();
    loadDelegators();
  }

  void loadDelegators() async {
    var uri =
        Uri.parse('https://api.hive-keychain.com/hive/delegators/cleanplanet');
    var request = http.Request('GET', uri);
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
        });
      } else {
        _showError("Status code is ${responseFinance.statusCode}");
      }
    } else {
      _showError("Status code is ${response.statusCode}");
    }
  }

  void _showError(String string) {
    var snackbar = SnackBar(content: Text('Error: $string'));
    Scaffold.of(context).showSnackBar(snackbar);
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
          const Text('Hive Delegators'),
        ],
      ),
    );
  }

  Widget getBody(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      itemBuilder: (c, i) {
        return ListTile(
          title: Text(items[i].delegator),
          trailing: Text('${items[i].delegated.toStringAsFixed(3)} HP'),
        );
      },
      separatorBuilder: (c, i) => const Divider(height: 0),
      itemCount: items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      drawer: const DrawerMenu(),
      body: getBody(context),
    );
  }
}

import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

class HiveDelegatorItem {
  final String delegator;
  final double delegated;
  HiveDelegatorItem({
    required this.delegator,
    required this.delegated,
  });
}

class HiveDelegatorsResponseItem {
  final String delegator;
  final double vestingShares;
  final String delegationDate;

  HiveDelegatorsResponseItem({
    this.delegator = "",
    this.vestingShares = 0.0,
    this.delegationDate = "",
  });

  factory HiveDelegatorsResponseItem.fromJson(Map<String, dynamic>? json) =>
      HiveDelegatorsResponseItem(
        delegator: asString(json, 'delegator'),
        vestingShares: asDouble(json, 'vesting_shares'),
        delegationDate: asString(json, 'delegation_date'),
      );

  static List<HiveDelegatorsResponseItem> fromJsonString(String jsonStr) {
    final jsonList = json.decode(jsonStr) as List;
    return jsonList.map((e) => HiveDelegatorsResponseItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        'delegator': delegator,
        'vesting_shares': vestingShares,
        'delegation_date': delegationDate,
      };
}

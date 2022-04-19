import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

List<DTubeHistoryItemRecord> decodeStringOfDTubeHistory(String jsonString) {
  final jsonList = json.decode(jsonString) as List;
  final list = jsonList.map((e) => DTubeHistoryItemRecord.fromJson(e)).toList();
  return list;
  //.where((e) => e.type == 19).toList();
}

class DTubeHistoryItemRecord {
  final List<DTubeHistoryItem> txs;

  DTubeHistoryItemRecord({
    required this.txs,
  });

  factory DTubeHistoryItemRecord.fromJson(Map<String, dynamic>? json) {
    var array = json?['txs'] as List<dynamic>? ?? [];
    var mappedArray = array.map((e) => DTubeHistoryItem.fromJson(e));
    return DTubeHistoryItemRecord(txs: mappedArray.toList());
  }
}

class DTubeHistoryItem {
  final int type;
  final DTubeHistoryData data;

  DTubeHistoryItem({
    required this.type,
    required this.data,
  });

  factory DTubeHistoryItem.fromJson(Map<String, dynamic>? json) =>
      DTubeHistoryItem(
        type: asInt(json, 'type'),
        data: DTubeHistoryData.fromJson(asMap(json, 'data')),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'data': data.toJson(),
      };
}

class DTubeHistoryData {
  final String author;
  final String link;
  final int vt;
  final int tip;

  DTubeHistoryData({
    this.author = "",
    this.link = "",
    this.vt = 0,
    this.tip = 0,
  });

  factory DTubeHistoryData.fromJson(Map<String, dynamic>? json) =>
      DTubeHistoryData(
        author: asString(json, 'author'),
        link: asString(json, 'link'),
        vt: asInt(json, 'vt'),
        tip: asInt(json, 'tip'),
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'link': link,
        'vt': vt,
        'tip': tip,
      };
}

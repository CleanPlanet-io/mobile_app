import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

List<DTubeHistoryItem> decodeStringOfDTubeHistory(String jsonString) {
  final jsonList = json.decode(jsonString) as List;
  final list = jsonList.map((e) => DTubeHistoryItem.fromJson(e)).toList();
  return list;
  //.where((e) => e.type == 19).toList();
}

class DTubeHistoryItem {
  final int type;
  final DTubeHistoryData data;
  final String sender;
  final int ts;
  final String hash;
  final String signature;
  final int includedInBlock;

  DTubeHistoryItem({
    this.type = 0,
    required this.data,
    this.sender = "",
    this.ts = 0,
    this.hash = "",
    this.signature = "",
    this.includedInBlock = 0,
  });

  factory DTubeHistoryItem.fromJson(Map<String, dynamic>? json) =>
      DTubeHistoryItem(
        type: asInt(json, 'type'),
        data: DTubeHistoryData.fromJson(asMap(json, 'data')),
        sender: asString(json, 'sender'),
        ts: asInt(json, 'ts'),
        hash: asString(json, 'hash'),
        signature: asString(json, 'signature'),
        includedInBlock: asInt(json, 'includedInBlock'),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'data': data.toJson(),
        'sender': sender,
        'ts': ts,
        'hash': hash,
        'signature': signature,
        'includedInBlock': includedInBlock,
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

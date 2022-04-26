import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

class HivePostsResponse {
  final String jsonrpc;
  final List<HivePostsResponseResultItem> result;
  final int id;

  HivePostsResponse({
    this.jsonrpc = "",
    required this.result,
    this.id = 0,
  });

  factory HivePostsResponse.fromJson(Map<String, dynamic>? json) =>
      HivePostsResponse(
        jsonrpc: asString(json, 'jsonrpc'),
        result: asList(json, 'result')
            .map((e) => HivePostsResponseResultItem.fromJson(e))
            .toList(),
        id: asInt(json, 'id'),
      );

  factory HivePostsResponse.fromJsonString(String jsonString) =>
      HivePostsResponse.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => {
        'jsonrpc': jsonrpc,
        'result': result.map((e) => e.toJson()),
        'id': id,
      };
}

class HivePostsResponseResultItem {
  final String author;
  final String permlink;
  final String title;
  final String body;
  final HivePostsJsonMetadata jsonMetadata;
  final String created;
  final String updated;
  final double payout;
  final String pendingPayoutValue;
  final List<ActiveVotesItem> activeVotes;

  HivePostsResponseResultItem({
    this.author = "",
    this.permlink = "",
    this.title = "",
    this.body = "",
    required this.jsonMetadata,
    this.created = "",
    this.updated = "",
    this.payout = 0.0,
    this.pendingPayoutValue = "",
    required this.activeVotes,
  });

  factory HivePostsResponseResultItem.fromJson(Map<String, dynamic>? json) =>
      HivePostsResponseResultItem(
        author: asString(json, 'author'),
        permlink: asString(json, 'permlink'),
        title: asString(json, 'title'),
        body: asString(json, 'body'),
        jsonMetadata:
            HivePostsJsonMetadata.fromJson(asMap(json, 'json_metadata')),
        created: asString(json, 'created'),
        updated: asString(json, 'updated'),
        payout: asDouble(json, 'payout'),
        pendingPayoutValue: asString(json, 'pending_payout_value'),
        activeVotes: asList(json, 'active_votes')
            .map((e) => ActiveVotesItem.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'permlink': permlink,
        'title': title,
        'body': body,
        'json_metadata': jsonMetadata.toJson(),
        'created': created,
        'updated': updated,
        'payout': payout,
        'pending_payout_value': pendingPayoutValue,
        'active_votes': activeVotes.map((e) => e.toJson()),
      };
}

class HivePostsJsonMetadata {
  final List<String> tags;
  final String app;
  final String type;
  final List<String> image;
  final String description;

  HivePostsJsonMetadata({
    required this.tags,
    this.app = "",
    this.type = "",
    this.description = "",
    required this.image,
  });

  factory HivePostsJsonMetadata.fromJson(Map<String, dynamic>? json) =>
      HivePostsJsonMetadata(
        tags: asList(json, 'tags').map((e) => e.toString()).toList(),
        app: asString(json, 'app'),
        type: asString(json, 'type'),
        description: asString(json, 'description'),
        image: asList(json, 'image').map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'tags': tags.map((e) => e),
        'app': app,
        'type': type,
        'image': image.map((e) => e),
      };
}

class ActiveVotesItem {
  final int rshares;
  final String voter;

  ActiveVotesItem({
    this.rshares = 0,
    this.voter = "",
  });

  factory ActiveVotesItem.fromJson(Map<String, dynamic>? json) =>
      ActiveVotesItem(
        rshares: asInt(json, 'rshares'),
        voter: asString(json, 'voter'),
      );

  Map<String, dynamic> toJson() => {
        'rshares': rshares,
        'voter': voter,
      };
}

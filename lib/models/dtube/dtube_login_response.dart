import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

class DTubeLoginBridgeResponse {
  final bool valid;
  final String accountName;
  final String key;
  final String error;

  DTubeLoginBridgeResponse({
    required this.valid,
    required this.accountName,
    required this.key,
    required this.error,
  });

  factory DTubeLoginBridgeResponse.fromJson(Map<String, dynamic>? json) =>
      DTubeLoginBridgeResponse(
        valid: asBool(json, 'valid'),
        accountName: asString(json, 'accountName'),
        key: asString(json, 'key'),
        error: asString(json, 'error'),
      );

  factory DTubeLoginBridgeResponse.fromJsonString(String jsonString) =>
      DTubeLoginBridgeResponse.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => {
        'valid': valid,
        'accountName': accountName,
        'key': key,
        'error': error,
      };
}

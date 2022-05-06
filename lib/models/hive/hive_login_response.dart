import 'dart:convert';

import 'package:mobile_app/models/new_videos_feed/safe_convert.dart';

class HiveLoginBridgeResponse {
  final bool valid;
  final String accountName;
  final String postingKey;
  final String error;

  HiveLoginBridgeResponse({
    required this.valid,
    required this.accountName,
    required this.postingKey,
    required this.error,
  });

  factory HiveLoginBridgeResponse.fromJson(Map<String, dynamic>? json) =>
      HiveLoginBridgeResponse(
        valid: asBool(json, 'valid'),
        accountName: asString(json, 'accountName'),
        postingKey: asString(json, 'postingKey'),
        error: asString(json, 'error'),
      );

  factory HiveLoginBridgeResponse.fromJsonString(String jsonString) =>
      HiveLoginBridgeResponse.fromJson(json.decode(jsonString));

  Map<String, dynamic> toJson() => {
        'valid': valid,
        'accountName': accountName,
        'postingKey': postingKey,
        'error': error,
      };
}

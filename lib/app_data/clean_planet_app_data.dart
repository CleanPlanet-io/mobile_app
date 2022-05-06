import 'dart:async';

class DTubeUserData {
  String username;
  String key;

  DTubeUserData({
    required this.username,
    required this.key,
  });
}

class HiveUserData {
  String username;
  String postingKey;

  HiveUserData({
    required this.username,
    required this.postingKey,
  });
}

class CleanPlanetAppData {
  DTubeUserData? dTubeUserData;
  HiveUserData? hiveUserData;

  CleanPlanetAppData({
    required this.dTubeUserData,
    required this.hiveUserData,
  });

  static final _appDataController = StreamController<CleanPlanetAppData>();
  static Stream<CleanPlanetAppData> get userData {
    return _appDataController.stream;
  }

  static void updateUserData(CleanPlanetAppData data) {
    _appDataController.sink.add(data);
  }
}

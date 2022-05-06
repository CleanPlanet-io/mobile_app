import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/app_data/clean_planet_app_data.dart';
import 'package:mobile_app/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create storage
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    CleanPlanetAppData.updateUserData(
      CleanPlanetAppData(
        hiveUserData: null,
        dTubeUserData: null,
      ),
    );
    loadData();
  }

  void loadData() async {
    String? dUsername = await storage.read(key: 'dUsername');
    String? dKey = await storage.read(key: 'dKey');
    String? hUsername = await storage.read(key: 'hUsername');
    String? hKey = await storage.read(key: 'hKey');
    var dTube = (dUsername != null &&
            dKey != null &&
            dUsername.isNotEmpty &&
            dKey.isNotEmpty)
        ? DTubeUserData(username: dUsername, key: dKey)
        : null;
    var hive = (hUsername != null &&
            hKey != null &&
            hUsername.isNotEmpty &&
            hKey.isNotEmpty)
        ? HiveUserData(username: hUsername, postingKey: hKey)
        : null;
    var newValue = CleanPlanetAppData(
      dTubeUserData: dTube,
      hiveUserData: hive,
    );
    CleanPlanetAppData.updateUserData(newValue);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CleanPlanetAppData?>.value(
      value: CleanPlanetAppData.userData,
      initialData: null,
      child: MaterialApp(
        title: 'cleanplanet.io',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

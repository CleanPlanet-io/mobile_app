import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app/app_data/clean_planet_app_data.dart';
import 'package:mobile_app/models/dtube/dtube_login_response.dart';
import 'package:provider/provider.dart';

class DTubeLoginScreen extends StatefulWidget {
  const DTubeLoginScreen({Key? key}) : super(key: key);

  @override
  State<DTubeLoginScreen> createState() => _DTubeLoginScreenState();
}

class _DTubeLoginScreenState extends State<DTubeLoginScreen> {
  var isLoading = false;
  static const platform = MethodChannel('io.cleanplanet.app/auth');
  var username = '';
  var key = '';

  // Create storage
  final storage = const FlutterSecureStorage();

  void onLoginTapped() async {
    var currentValue = Provider.of<CleanPlanetAppData?>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      final String result = await platform.invokeMethod('validateDTube', {
        'username': username,
        'key': key,
      });
      var response = DTubeLoginBridgeResponse.fromJsonString(result);
      if (response.valid && response.error.isEmpty) {
        debugPrint("Successful login");
        await storage.write(key: 'dUsername', value: username);
        await storage.write(key: 'dKey', value: key);
        var newValue = CleanPlanetAppData(
          dTubeUserData: DTubeUserData(
            key: key,
            username: username,
          ),
          hiveUserData: currentValue?.hiveUserData,
        );
        CleanPlanetAppData.updateUserData(newValue);
        Navigator.of(context).pop();
      } else {
        showError(response.error);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showError('Error occurred - ${e.toString()}');
    }
  }

  void showError(String string) {
    var snackBar = SnackBar(content: Text('Error: $string'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _loginForm() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              label: Text('DTube Username'),
              hintText: 'DTube username here',
            ),
            autocorrect: false,
            onChanged: (value) {
              setState(() {
                username = value;
              });
            },
            enabled: isLoading ? false : true,
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.key),
              label: Text('DTube Private Key'),
              hintText: 'Copy & paste key here',
            ),
            onChanged: (value) {
              setState(() {
                key = value;
              });
            },
            enabled: isLoading ? false : true,
          ),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: onLoginTapped,
                  child: const Text('Log in'),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _loginForm(),
    );
  }
}

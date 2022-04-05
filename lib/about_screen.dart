import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutHomeScreen extends StatelessWidget {
  const AboutHomeScreen({Key? key}) : super(key: key);

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
          const Text('CleanPlanet.io'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.twitter),
            title: const Text('Follow us on Twitter'),
            onTap: () {
              launch(
                  'https://twitter.com/cleanplanet_?utm_source=io.cleanplanet.app');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.telegram),
            title: const Text('Follow us on Facebook'),
            onTap: () {
              launch(
                  'https://www.facebook.com/CleanPlanett/?tn-str=k*F?utm_source=io.cleanplanet.app');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.discord),
            title: const Text('Join us on Discord'),
            onTap: () {
              launch(
                  'https://discord.gg/7v5USHP?utm_source=io.cleanplanet.app');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.instagram),
            title: const Text('Follow us on Instagram'),
            onTap: () {
              launch('https://www.instagram.com/cleanplanet__/');
            },
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.medium),
            title: const Text('Follow us on Medium'),
            onTap: () {
              launch('https://medium.com/@contact.cleanplanet');
            },
          ),
        ],
      ),
    );
  }
}

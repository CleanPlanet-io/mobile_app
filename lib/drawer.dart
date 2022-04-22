import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/about_faq.dart';
import 'package:mobile_app/about_screen.dart';
import 'package:mobile_app/dtube/dtube_curation_screen.dart';
import 'package:mobile_app/dtube/dtube_home_screen.dart';
import 'package:mobile_app/home_screen.dart';
import 'package:mobile_app/media_kit.dart';
import 'package:mobile_app/ranking.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  Widget _drawerHeader(BuildContext context) {
    return DrawerHeader(
      child: InkWell(
        child: Column(
          children: [
            Image.asset(
              "assets/fullLogo.png",
              width: 60,
              height: 60,
            ),
            const SizedBox(height: 5),
            Text(
              "CleanPlanet.io",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 5),
            Text(
              "Eco-citizen rewarded act",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pop();
          var screen = const AboutHomeScreen();
          var route = MaterialPageRoute(builder: (_) => screen);
          Navigator.of(context).pushReplacement(route);
        },
      ),
    );
  }

  Widget _homeMenu(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("Home"),
      onTap: () {
        Navigator.of(context).pop();
        var screen = const MyHomePage();
        var route = MaterialPageRoute(builder: (_) => screen);
        Navigator.of(context).pushReplacement(route);
      },
    );
  }

  Widget _privacy(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.policy),
      title: const Text("Privacy Policy"),
      onTap: () {
        var screen = const AboutPrivacy();
        var route = MaterialPageRoute(builder: (_) => screen);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(route);
      },
    );
  }

  Widget _ranking(BuildContext context) {
    return ListTile(
      leading: const FaIcon(FontAwesomeIcons.rankingStar),
      title: const Text("Ranking SMT"),
      onTap: () {
        var screen = const RankingScreen();
        var route = MaterialPageRoute(builder: (_) => screen);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(route);
      },
    );
  }

  Widget _media(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.newspaper),
      title: const Text("Media Kit"),
      onTap: () {
        var screen = const MediaKitScreen();
        var route = MaterialPageRoute(builder: (_) => screen);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(route);
      },
    );
  }

  Widget _drawerMenu(BuildContext context) {
    return ListView(
      children: [
        _drawerHeader(context),
        _homeMenu(context),
        _ranking(context),
        _media(context),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.video),
          title: const Text('D.Tube Channel'),
          onTap: () {
            Navigator.of(context).pop();
            var screen = const DTubeHomeScreen(
              title: 'CleanPlanet DTube Channel',
              path: 'blog/cleanplanet',
            );
            var route = MaterialPageRoute(builder: (c) => screen);
            Navigator.of(context).pushReplacement(route);
          },
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.video),
          title: const Text('Videos'),
          subtitle: const Text('Curated by CleanPlanet.io'),
          onTap: () {
            Navigator.of(context).pop();
            var screen = const DTubeCurationScreen();
            var route = MaterialPageRoute(builder: (c) => screen);
            Navigator.of(context).pushReplacement(route);
          },
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.blog),
          title: const Text('Follow us on Hive'),
          onTap: () {
            Navigator.of(context).pop();
            launch('https://hive.blog/@cleanplanet');
          },
        ),
        ListTile(
          leading: const Icon(Icons.call),
          title: const Text('Contact Us'),
          onTap: () {
            Navigator.of(context).pop();
            var screen = const AboutHomeScreen();
            var route = MaterialPageRoute(builder: (_) => screen);
            Navigator.of(context).pushReplacement(route);
          },
        ),
        _privacy(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: _drawerMenu(context));
  }
}

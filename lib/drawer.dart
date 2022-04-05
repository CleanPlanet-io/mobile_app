import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app/about_faq.dart';
import 'package:mobile_app/about_screen.dart';
import 'package:mobile_app/ranking.dart';

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
          var screen = const AboutHomeScreen();
          var route = MaterialPageRoute(builder: (_) => screen);
          Navigator.of(context).push(route);
        },
      ),
    );
  }

  Widget _homeMenu(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("Home"),
      onTap: () {
        // TO-DO: do something here
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
        Navigator.of(context).push(route);
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
        Navigator.of(context).push(route);
      },
    );
  }

  Widget _media(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.newspaper),
      title: const Text("Media Kit"),
      onTap: () {
        var screen = const RankingScreen();
        var route = MaterialPageRoute(builder: (_) => screen);
        Navigator.of(context).push(route);
      },
    );
  }

  Widget _drawerMenu(BuildContext context) {
    return ListView(
      children: [
        _drawerHeader(context),
        _homeMenu(context),
        _privacy(context),
        _ranking(context),
        _media(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: _drawerMenu(context));
  }
}

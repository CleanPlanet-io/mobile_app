import 'package:flutter/material.dart';
import 'package:mobile_app/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  List<Widget> section1() {
    return [
      Row(
        children: [
          const Spacer(),
          Image.asset('assets/home_love_planet.png'),
          const Spacer(),
        ],
      ),
      const SizedBox(height: 10),
      Text("Eco-citizen rewarded act",
          style: Theme.of(context).textTheme.headline5),
      Text(
          "Make tomorrow a better world, be rewarded today. Join the project by following us and be part of the Initiative!",
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> section2() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          const Spacer(),
          Image.asset('assets/save_world.png'),
          const Spacer(),
        ],
      ),
      const SizedBox(height: 10),
      Text("Earth is our home, taking care of it should be our primary action.",
          style: Theme.of(context).textTheme.headline5),
      Text(
          "At CLEAN PLANET we really trust in the power of individual action. We can act today, for a better world tomorrow.",
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> section3() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          const Spacer(),
          Image.asset('assets/home_love_mountains.jpeg'),
          const Spacer(),
        ],
      ),
      const SizedBox(height: 10),
      Text("What is Clean Planet? Combo ecology act and technology",
          style: Theme.of(context).textTheme.headline5),
      Text(
          "Cleanplanet is an ecological movement that aims to reward small but important citizen’s gestures for our beautiful planet. The first thing you can do for the planet is to pick up wastes that lays in the Nature. In addition you will be rewarded with crypto currency. Amazing no?",
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> sectionVideos(BuildContext context) {
    return [
      const SizedBox(height: 10),
      InkWell(
        child: const Text('Click to watch video',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 26,
            )),
        onTap: () {
          launch('https://youtu.be/psqs_kMZCig');
        },
      ),
      const SizedBox(height: 10),
      InkWell(
        child: const Text('Another video',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 26,
            )),
        onTap: () {
          launch(
              'https://d.tube/#!/v/yann0975/QmWDSHz2T2MbUYkQVbcrzXtK6NcaNTYD8CAurXq3DNSrwj');
        },
      ),
      const SizedBox(height: 10),
      InkWell(
        child: const Text('Latest video',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 26,
            )),
        onTap: () {
          launch('https://d.tube/v/kchheap111/ahwcrxmfxtw');
        },
      ),
    ];
  }

  List<Widget> section5() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          const Spacer(),
          Image.asset('assets/future.jpeg'),
          const Spacer(),
        ],
      ),
      const SizedBox(height: 10),
      Text("Make a better world, earn tokens",
          style: Theme.of(context).textTheme.headline5),
      Text("Join Clean Planet and earn money by cleaning up the Planet. ",
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> section6() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Text("How can you start?", style: Theme.of(context).textTheme.headline4),
      const SizedBox(height: 10),
      Text("PROVE IT", style: Theme.of(context).textTheme.headline6),
      Text(
          "Take a dated video or some dated pictures of you or your friends while you pick up litter, put what you have collected in a public trash.",
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text("UPLOAD IT", style: Theme.of(context).textTheme.headline6),
      Text(
          "Upload your video or photos report on the social network - d.tube / Hive.blog",
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text("GET REWARDED", style: Theme.of(context).textTheme.headline6),
      Text(
          "Get rewarded for your eco-citizen act by the vote/like of the Community!",
          style: Theme.of(context).textTheme.bodyLarge),
      InkWell(
        child: const Text('Open D.tube',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 26,
            )),
        onTap: () {
          launch('https://d.tube');
        },
      ),
      const SizedBox(height: 10),
      InkWell(
        child: const Text('Open Hive.blog',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 26,
            )),
        onTap: () {
          launch('https://hive.blog');
        },
      ),
    ];
  }

  List<Widget> section7() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Text("Impact", style: Theme.of(context).textTheme.headline4),
      Text("+28", style: Theme.of(context).textTheme.headline6),
      Text("PARTICIPATING COUNTRIES",
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text("+110", style: Theme.of(context).textTheme.headline6),
      Text("DONORS", style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text("+1,300", style: Theme.of(context).textTheme.headline6),
      Text("REALIZED CLEAN PLANET ACT",
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text("+37,000SP", style: Theme.of(context).textTheme.headline6),
      Text("Delegation", style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text("+15,000HP", style: Theme.of(context).textTheme.headline6),
      Text("Delegation", style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: section1() +
            section2() +
            section3() +
            sectionVideos(context) +
            section5() +
            section6() +
            section7(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(context),
      drawer: const DrawerMenu(),
    );
  }
}

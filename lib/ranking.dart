import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<Widget> headers() {
    return [
      Text(
        'The ranking of all our users',
        style: Theme.of(context).textTheme.headline5,
      ),
      const SizedBox(height: 10),
      Text(
        'These tables allow you to consult the number of points allocated to each user according to their donations and actions, in complete transparency. We update this data daily.\n\nThese points will allow the future Clean Tokens to be distributed on a pro rata basis.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ];
  }

  List<Widget> cleaners() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          const FaIcon(FontAwesomeIcons.recycle),
          const SizedBox(width: 10),
          Text('Cleaners', style: Theme.of(context).textTheme.headline5),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
          'Maybe you’re already a Cleaner. In that case, Earth already thanks you.'),
      const SizedBox(height: 10),
      InkWell(
        child: const Text('Show me list of cleaners',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 20,
            )),
        onTap: () {
          launch(
              'https://docs.google.com/spreadsheets/d/e/2PACX-1vStB28YXE_jXvWurEZgnDNAyH_6VEVQVOlcUkNIVOF6Duvbua_uYv4QuEGWPfN3opt8BZWNM0ywFJxj/pubhtml?gid=76090474&single=true');
        },
      ),
    ];
  }

  List<Widget> delegators() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          const FaIcon(FontAwesomeIcons.person),
          const SizedBox(width: 10),
          Text('Delegators', style: Theme.of(context).textTheme.headline5),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
          'All the members of Steem/Hive/DTube who have offered us part of their power, allowing us to reward our cleaners community even better.'),
      const SizedBox(height: 10),
      InkWell(
        child: const Text('List of Delegators',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 20,
            )),
        onTap: () {
          launch(
              'https://docs.google.com/spreadsheets/d/e/2PACX-1vStB28YXE_jXvWurEZgnDNAyH_6VEVQVOlcUkNIVOF6Duvbua_uYv4QuEGWPfN3opt8BZWNM0ywFJxj/pubhtml?gid=859264065&single=true');
        },
      ),
    ];
  }

  List<Widget> earlyDelegators() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Row(
        children: [
          const FaIcon(FontAwesomeIcons.thumbsUp),
          const SizedBox(width: 10),
          Text('Early Delegators',
              style: Theme.of(context).textTheme.headline5),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
          'The period is over. It was the pilgrim fathers who made it possible for the project to reach you! We would like to thank them again warmly.'),
      const SizedBox(height: 10),
      InkWell(
        child: const Text('Early Delegators',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue,
              fontSize: 20,
            )),
        onTap: () {
          launch(
              'https://docs.google.com/spreadsheets/d/e/2PACX-1vStB28YXE_jXvWurEZgnDNAyH_6VEVQVOlcUkNIVOF6Duvbua_uYv4QuEGWPfN3opt8BZWNM0ywFJxj/pubhtml?gid=1267584121&single=true');
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                headers() + cleaners() + delegators() + earlyDelegators()),
      ),
    );
  }
}

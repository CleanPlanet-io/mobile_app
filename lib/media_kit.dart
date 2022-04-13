import 'package:flutter/material.dart';

class MediaKitScreen extends StatefulWidget {
  const MediaKitScreen({Key? key}) : super(key: key);

  @override
  State<MediaKitScreen> createState() => _MediaKitScreenState();
}

class _MediaKitScreenState extends State<MediaKitScreen> {
  List<Widget> _getHeader() {
    return [
      Text('Team', style: Theme.of(context).textTheme.headline4),
      Text(
          'Sylvain and Yannick, the two co-founders, initially alone at first, were joined by Charles, who gave them first-rate support during the first presentation of the project at the Steem Fest in Krakow. Some time later, Jesse joined them to support them and bring his expertise in branding and communication-marketing',
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> _yannick() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Text('Yannick RODRIGUES', style: Theme.of(context).textTheme.headline5),
      Text('Co-founder', style: Theme.of(context).textTheme.headline6),
      SizedBox(
        width: 200,
        height: 200,
        child: Image.asset('assets/yannick.jpg', fit: BoxFit.fitWidth),
      ),
      Text(
          'Nurse in private practice, born in 1975. I have always been concerned about environmental cleanliness because of my parental education. I am a fervent actor in the cause on a daily basis… without extremism of any kind but following good behavioural practices. One morning the idea of Clean Planet came up following an awareness of our degraded modern environment. We created Clean Planet with Sylvain. Clean Planet is a modern way to concern everyone for their participation in the clean-up. Clean Planet is now an official association that rewards each actor who joins it with a digital token.',
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> _sylvain() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Text('Sylvain FONTFREYDE', style: Theme.of(context).textTheme.headline5),
      Text('Co-founder', style: Theme.of(context).textTheme.headline6),
      SizedBox(
        width: 200,
        height: 200,
        child: Image.asset('assets/sylvain.jpg', fit: BoxFit.fitWidth),
      ),
      Text(
          'I am Sylvain, I am 39 years old and for more than 15 years I have been working independently. I created a company in personal services and one in the manufacture and sale of electronic products. At the same time, in 2012 I am passionate about Blockchain technology and its world of crypto-currencies. As a self-taught person this passion led me to Steem (1st social blockchain) and from one meeting to the next I came to co-found Clean Planet: one of my objectives with this eco-citizen movement is to highlight the Advantages of Blockchain technology to face the urgency of certain problems.',
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> _charles() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Text('Charles LECHOUX', style: Theme.of(context).textTheme.headline5),
      Text('Business developer', style: Theme.of(context).textTheme.headline6),
      SizedBox(
        width: 200,
        height: 200,
        child: Image.asset('assets/charles.jpg', fit: BoxFit.fitWidth),
      ),
      Text(
          'During a trip to Thailand organized by Project Abroad, I discovered this passion for eco-will. During my stay, I was able to expand my knowledge of environmental project management. It seemed natural to me to take advantage of this enriching experience and to combine it with the technological advances of the social blockchain in connection with cryptocurrency. This is done thanks to Sylvain and Yannick’s ingenious idea of a social network at the service of the planet: Clean Planet.',
          style: Theme.of(context).textTheme.bodyLarge),
    ];
  }

  List<Widget> _getHistory() {
    return [
      const SizedBox(height: 10),
      const Divider(height: 1),
      const SizedBox(height: 10),
      Text('History', style: Theme.of(context).textTheme.headline4),
      Text('FEBRUARY-MAY 2018', style: Theme.of(context).textTheme.headline6),
      Text(
          'Yannick RODRIGUES and Sylvain FONTFREYDE observe with disgust the spread of litter of all kinds. The situation is alarming, it is estimated that 60Kg of cigarette butts, packaging, cans and various types of garbage are dumped per second, only on French soil. Active users of the Steem and Hive social blockchains, allowing to reward content creators without intermediaries, Sylvain and Yannick had an idea: Encourage network users to act individually for the environment by offering them a reward system linked to a new community that would have the simple and descriptive name of “Clean Planet”.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('JULY 2018', style: Theme.of(context).textTheme.headline6),
      Text(
          'Clean Planet starts the proof of act award according to its rules: – Show or Prove the Current Date of the Act – Show and prove the collection action step by step by taking photographs or filming yourself. – Place the collected waste in a public waste bin or a scheduled collection point – Use the Tag cleanplanet for any publication On this date the co-founder invests their personal tokens to have a minimum voting power.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('OPERATION', style: Theme.of(context).textTheme.headline6),
      Text(
          'The Hive and Steem network user must film himself collecting litter, which he will put in a small bag with today’s date, before throwing it in a garbage can. He will then upload his video on the network by identifying @cleanplanet, in order to link it to the community of “cleaners”, who will be able to enjoy its content to reward him. This is the “proof of act”. For information purposes, a content creator can now be rewarded up to the equivalent of €8 per content presented to the community!',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('SEPTEMBER 2018', style: Theme.of(context).textTheme.headline6),
      Text(
          'With the evolution of information, the basis of the cause, several delegations of authority arrive on the CLEAN PLANET account and the equivalent of \$10,000 of delegation is reached.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('NOVEMBER 2018', style: Theme.of(context).textTheme.headline6),
      Text(
          'is organized the World presentation of the Movement and the entity Clean Planet in Krakow on the occasion of the Steemfest (Steem Annual Festival) On this occasion Charles LECHOUX, an English-speaking person, joined the team as a Business/Communication Developer.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('JANUARY 2019', style: Theme.of(context).textTheme.headline6),
      Text(
          'Yannick and Sylvain wish to develop their concept and acquire new users to allow a real societal impact. At that time, Clean Planet already have 90 donors, more than 500 users in 25 different countries and have already collected 35,000 Steem power (virtual currency allowing them to best reward their community). The objective is now simple: to disseminate the project as widely as possible in order to prepare the launch of a mobile application that will allow the community to meet and upload its content even more easily.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('MARCH 2019', style: Theme.of(context).textTheme.headline6),
      Text(
          '38000 STEEM POWER reached – 25 contents published per day on average – Active search for a mobile application developer – Preparation of the CLEAN TOKEN for market opening April 15 in pre-sale – April 20 for sale – Creation of an association under the 1901 law in FRANCE – 24 MARCH 2019 – Publication of an article in a local newspaper “La Montagne” – Growing interest in other media. 2019, May 17 to 19 in BARCELONA : Presentation of a promotional video for an official presentation at Dtube Forum Event.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('2019, November', style: Theme.of(context).textTheme.headline6),
      Text('CLEAN PLANET participate at STEEMFEST 4 Event at BANGKOK Thailand',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('2020, August', style: Theme.of(context).textTheme.headline6),
      Text(
          'CLEAN PLANET join Seeds Community and make a proposal to reward cleaner of the Planet with Seeds Token : 500 000 Seeds allocated to reward People from November 1st. 500 Seeds per person one time.',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('2020, September 27th',
          style: Theme.of(context).textTheme.headline6),
      Text(
          'Radio Slot on a well known French RADIO call FRANCE INTER where CLEAN PLANET is discover as an example to use Cryptocurrency in real Life',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 10),
      Text('2020, September', style: Theme.of(context).textTheme.headline6),
      Text(
          '2020, September Edition of an environment newspaper, CLEAN PLANET got an entire page',
          style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 20),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Kit'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: _getHeader() +
                _yannick() +
                _sylvain() +
                _charles() +
                _getHistory(),
          ),
        ),
      ),
    );
  }
}

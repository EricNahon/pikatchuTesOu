import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:maisouestpikachu/constants.dart';
import 'package:maisouestpikachu/model/pokemon.dart';

victoryRewards rewards;
String soundRewardUrl;
String animRewardUrl;

fetchRewards  () async {
  var res = await http.get(kUrlRewards);
  var decodedJson = jsonDecode(res.body);
  rewards = victoryRewards.fromJson(decodedJson);

  print(rewards.toJson());

  var rng = Random();
  var indexAnim = rng.nextInt(rewards.anim_urls.length);
  animRewardUrl = rewards.anim_urls[indexAnim];
}

class FoundPage extends StatelessWidget {
  FoundPage({@required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {

    fetchRewards();

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'Bravo !',
                    style: kTitleTextStyle,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),

                  Image.asset(
                    'assets/images/VictoryBadge.png',
                    fit: BoxFit.fill,
                    width: 50.0,
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.network(animRewardUrl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
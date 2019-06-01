import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:maisouestpikachu/constants.dart';
import 'package:maisouestpikachu/model/pokemon.dart';
import 'package:maisouestpikachu/ui/draw_horizontal_line.dart';

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
        title: Center(child: Text('Bravo !', textAlign: TextAlign.center)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/pikachu.gif',
              fit: BoxFit.fill,
              width: 40.0,
              height: 40.0,
            ),
          ),
          Divider(height: 1.0),
          Expanded(
            flex: 3,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.network(animRewardUrl != null ? animRewardUrl : kDefaultUrlReward)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
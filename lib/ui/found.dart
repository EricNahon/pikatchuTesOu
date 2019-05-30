import 'package:flutter/material.dart';
import 'package:maisouestpikachu/constants.dart';
import 'package:maisouestpikachu/model/pokemon.dart';

class FoundPage extends StatelessWidget {
  FoundPage({@required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
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
                  Hero(
                    tag: pokemon.img,
                    child: Container(
                        child: Image.asset(
                          'assets/images/pikachu_0.gif',
                          fit: BoxFit.fill,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColour = Color(0xFF1D1E33);
const kInactiveCardColour = Color(0xFF111328);
const kBottomContainerColour = Color(0xFFEB1555);

const String kTitle = "Pikachu t'es où ?";

const String kUrlPokedex = "https://raw.githubusercontent.com/EricNahon/pikatchuTesOu/master/remotedata/pokedex.json";
const String kUrlRewards = "https://raw.githubusercontent.com/EricNahon/pikatchuTesOu/master/remotedata/rewards.json";
const String kDefaultUrlReward = "https://raw.githubusercontent.com/EricNahon/pikatchuTesOu/master/remotedata/images/Bulbasaur.gif";

const kLabelTextStyle = TextStyle (
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kNumberTextStyle = TextStyle (
  fontSize: 50.0,
  fontWeight: FontWeight.w900
);

const kLargeButtonTextStyle = TextStyle (
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle (
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle (
  color: Color(0xFF24D876),
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle (
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle (
  fontSize: 22.0,
);

const kGameHowTo = '''
6 pokemons choisis au hasard s'affichent à l'écran.
Derrière un seul de l'un deux se cache Pikachu.
Touche le pokemon de ton choix pour voir si Pikachu se cache derrière lui.
''';
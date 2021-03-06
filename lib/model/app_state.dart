import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../ui/pages/details_page_portrait.dart';
import '../ui/pages/details_page_landscape.dart';
import '../ui/pages/found_page.dart';
import '../ui/ui_helper.dart';

import 'constants.dart';
import 'pokemon.dart';

class AppState with ChangeNotifier {
  AppState() {
    getAppInfo();
    fetchData();
  }

  PackageInfo packageInfo;

  String appVersion;
  static AudioCache player = AudioCache();

  int currentBottomTabIndex = 0;

  PokeDex _pokeDex;
  PokeDex get pokeDex => _pokeDex;
  set pokeDex(PokeDex newValue) {
    if (newValue == null) {
      _pokeDex = PokeDex();
    } else {
      _pokeDex = newValue;
    }

    notifyListeners();
  }

  int _hidingPikachuCardIndex = 0;
  int get hidingPikachuCardIndex => _hidingPikachuCardIndex;
  set hidingPikachuCardIndex(int newValue) {
    _hidingPikachuCardIndex = newValue;
    notifyListeners();
  }

  String _animRewardUrl;
  String get animRewardUrl => _animRewardUrl;
  set animRewardUrl(String newValue) {
    _animRewardUrl = newValue;
    notifyListeners();
  }

  List<Pokemon> _selectedPokemon = List<Pokemon>();
  List<Pokemon> _distinctPokemons = List<Pokemon>();

  bool _isFetching = true;
  bool get isFetching => _isFetching;
  set isFetching(bool newValue) {
    _isFetching = newValue;
    notifyListeners();
  }

  Future getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  //
  Future<void> fetchData() async {
    dynamic _response;
    _isFetching = true;

    notifyListeners();

    _response = await http.get(kUrlPokedex);
    if (_response.statusCode == 200) {
      var decodedJson = jsonDecode(_response.body);
      _pokeDex = PokeDex.fromJson(decodedJson);
    }

    _isFetching = false;

    if (_pokeDex == null) { return; }

    // select 6 random pokemon and put it in pokemon list
    var rng = Random();
    _distinctPokemons.clear();

    while (_distinctPokemons.length != 6) {
      var l = List.generate(6, (_) => rng.nextInt(_pokeDex.pokemons.length));
      _selectedPokemon.clear();
      l.forEach((item) => _selectedPokemon.add(_pokeDex.pokemons[item]));
      _distinctPokemons = _selectedPokemon.toSet().toList();
    }

    _pokeDex.pokemons = _distinctPokemons;
    //

    // hide pikachu somewhere in the list
    _hidingPikachuCardIndex = Random().nextInt(_pokeDex.pokemons.length);
    _pokeDex.pokemons[_hidingPikachuCardIndex].hidingPikachu = true;

    // load awards
    _response = await http.get(kUrlRewards);
    if (_response.statusCode == 200) {
      var decodedJson = jsonDecode(_response.body);
      VictoryRewards rewards = VictoryRewards.fromJson(decodedJson);
      var indexAnim = rng.nextInt(rewards.animUrls.length);
      _animRewardUrl = rewards.animUrls[indexAnim];
    }
    //

    if (_pokeDex != null) {
      print(_pokeDex.pokemons[0].name);
    }

    player.play('sounds/PikachuTeOu01.mp3');

    notifyListeners();
  }

  checkHiddenPikachu(BuildContext ctx, Pokemon poke, String rewardUrl) {
    if (!poke.hidingPikachu) {
      player.play('sounds/PikaPala02.mp3');
      Navigator.push(
        ctx,
        UIHelper.isPortrait(ctx: ctx) ?
        MaterialPageRoute(
          builder: (context) => DetailsPagePortrait(
            pokemon: poke,
          ),
        ) :
        MaterialPageRoute(
          builder: (context) => DetailsPageLandscape(
            pokemon: poke,
          ),
        ),
      );
    } else {
      player.play('sounds/applause.mp3');
      Navigator.push(ctx, MaterialPageRoute(builder: (context) => FoundPage(animRewardUrl: rewardUrl, pokemon: poke)));
    }
  }
}
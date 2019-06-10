import 'package:flutter/foundation.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'constants.dart';
import 'pokemon.dart';

class AppState with ChangeNotifier {
  AppState() {
    fetchData();
  }

  static AudioCache player = AudioCache();

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
      var l = List.generate(6, (_) => rng.nextInt(_pokeDex.pokemon.length));
      _selectedPokemon.clear();
      l.forEach((item) => _selectedPokemon.add(_pokeDex.pokemon[item]));
      _distinctPokemons = _selectedPokemon.toSet().toList();
    }

    _pokeDex.pokemon = _distinctPokemons;
    //

    // hide pikachu somewhere in the list
    _hidingPikachuCardIndex = Random().nextInt(_pokeDex.pokemon.length);
    _pokeDex.pokemon[_hidingPikachuCardIndex].hidingPikachu = true;

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
      print(_pokeDex.pokemon[0].name);
    }

    player.play('sounds/PikachuTeOu01.mp3');

    notifyListeners();
  }

}
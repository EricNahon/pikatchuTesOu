import 'package:flutter/material.dart';

import '../../ui/ui_helper.dart';
import 'pokemon_list_landscape.dart';
import 'pokemon_list_portrait.dart';

class PokeQuizz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UIHelper.isPortrait(ctx: context) ? PokemonListPortrait() :  PokemonListLandscape();
  }
}
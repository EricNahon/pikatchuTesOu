import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/app_state.dart';
import 'pokemon_list.dart';

class PokeQuizz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      children: <Widget>[
        PokemonList(),
      ],
    );
  }
}

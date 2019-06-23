import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/ui_helper.dart';
import '../../model/app_state.dart';

class PokemonListLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Center(
      child: Container(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: appState.pokeDex.pokemons
              .map((poke) => Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        appState.checkHiddenPikachu(context, poke, appState.animRewardUrl);
                      },
                      child: Card(
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(poke.img),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

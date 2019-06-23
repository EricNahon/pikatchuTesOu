import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/ui_helper.dart';
import '../../model/app_state.dart';

class PokemonListPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      children: <Widget>[
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: appState.pokeDex.pokemons
              .map((poke) => Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        appState.checkHiddenPikachu(context, poke, appState.animRewardUrl);
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Hero(
                              tag: poke.img,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(poke.img),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

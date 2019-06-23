import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/ui_helper.dart';
import '../../model/app_state.dart';

class PokemonListPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Center(
      child:
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.14 : 1.0,
          padding: MediaQuery.of(context).size.width > 600 ?  const EdgeInsets.all(20.0) : const EdgeInsets.all(0.0),
          children: appState.pokeDex.pokemons
              .map((poke) => Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        appState.checkHiddenPikachu(context, poke, appState.animRewardUrl);
                      },
                      child: Card(
                        child: Container(
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
    );
  }
}

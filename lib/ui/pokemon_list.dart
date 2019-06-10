import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';

import 'package:pikachutou/app_state.dart';
import 'package:pikachutou/model/pokemon.dart';
import 'found.dart';
import 'details.dart';

class PokemonList extends StatelessWidget {
  static AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: appState.pokeDex.pokemon
          .map((poke) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    checkHiddenPikachu(context, poke, player);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Hero(
                          tag: poke.img,
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(poke.img))),
                          ),
                        ),
                        Text(
                          poke.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  checkHiddenPikachu(BuildContext ctx, Pokemon poke, AudioCache victorySound) {
    if (!poke.hidingPikachu) {
      victorySound.play('sounds/PikaPala02.mp3');
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => Details(
                pokemon: poke,
              ),
        ),
      );
    } else {
      victorySound.play('sounds/applause.mp3');
      Navigator.push(ctx,
          MaterialPageRoute(builder: (context) => FoundPage(pokemon: poke)));
    }
  }
}

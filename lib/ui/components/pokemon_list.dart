import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';

import '../../model/app_state.dart';
import '../../model/pokemon.dart';
import '../pages/found_page.dart';
import '../pages/details_page.dart';

class PokemonList extends StatelessWidget {
  static AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: appState.pokeDex.pokemons
          .map((poke) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    checkHiddenPikachu(context, poke, player, appState.animRewardUrl);
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

  checkHiddenPikachu(BuildContext ctx, Pokemon poke, AudioCache sound, String rewardUrl) {
    if (!poke.hidingPikachu) {
      sound.play('sounds/PikaPala02.mp3');
      Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (context) => DetailsPage(
                pokemon: poke,
              ),
        ),
      );
    } else {
      sound.play('sounds/applause.mp3');
      Navigator.push(ctx,
          MaterialPageRoute(builder: (context) => FoundPage(animRewardUrl: rewardUrl,pokemon: poke)));
    }
  }
}

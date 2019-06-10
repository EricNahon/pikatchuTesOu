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
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      Icon(
                        Icons.refresh,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0),
                      Text('recharger',
                          style: TextStyle(
                              fontSize: 22.0, color: Colors.white)),
                      Spacer(),
                    ],
                  ),
                  onPressed: () {
                    appState.fetchData();
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

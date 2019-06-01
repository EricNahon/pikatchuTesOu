import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audio_cache.dart';

import 'package:maisouestpikachu/constants.dart';
import 'package:maisouestpikachu/model/pokemon.dart';
import 'package:maisouestpikachu/ui/details.dart';
import 'package:maisouestpikachu/ui/search.dart';
import 'package:maisouestpikachu/ui/found.dart';

class Home extends StatefulWidget {
  final String header;

  Home({Key key, this.header}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PokeDex pokedex;
  victoryRewards rewards;

  List<Pokemon> selectedPokemon = List<Pokemon>();
  List<Pokemon> distinctPokemons = List<Pokemon>();
  int pokemonIndexHiddenPikachu;
  bool _loading = true;
  static AudioCache player = AudioCache();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      _loading = true;
    });
    var res = await http.get(kUrlPokedex);
    var decodedJson = jsonDecode(res.body);
    pokedex = PokeDex.fromJson(decodedJson);

    var rng = Random();
    distinctPokemons.clear();

    while(distinctPokemons.length != 6) {
      var l = List.generate(6, (_) => rng.nextInt(pokedex.pokemon.length));
      selectedPokemon.clear();
      l.forEach((item) => selectedPokemon.add(pokedex.pokemon[item]));
      distinctPokemons = selectedPokemon.toSet().toList();
    }

    pokedex.pokemon = distinctPokemons;

    // hide pikachu somewhere in the list
    pokemonIndexHiddenPikachu = Random().nextInt(pokedex.pokemon.length);
    pokedex.pokemon[pokemonIndexHiddenPikachu].hidingPikachu = true;

    print(pokedex.pokemon[pokemonIndexHiddenPikachu].name);
    //

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      //AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.header,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: PokeSearch(pokeHub: pokedex),
                );
              })
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(kTitle,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
            ),
            ListTile(
              onTap: () {
                _showAlertInfo(context);
              },
              title: Text("A propos"),
              leading: Icon(Icons.info),
            ),
          ],
        ),
      ),

      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: pokedex.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            checkHiddenPikachu(poke, player);
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ),
      //FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }

  checkHiddenPikachu(Pokemon poke, AudioCache victorySound) {

    if (!poke.hidingPikachu) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                pokemon: poke,
              )));
    } else {
      victorySound.play('sounds/applause.mp3');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoundPage(
                pokemon: poke,
              )));
    }
  }

  //Function to Show Alert Dialog for showing app details
  void _showAlertInfo(BuildContext context) {
    var alert = new AlertDialog(
      title: Text("PokeNils"),
      content: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/ApitepBearLogo.png',
            fit: BoxFit.fill,
            width: 60.0,
            height: 60.0,
          ),
          SizedBox(
            width: 15.0,
          ),
          Text("Made by Apitep"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK"),
        )
      ],
    );

    showDialog(context: context, builder: (context) => alert);
  }
}

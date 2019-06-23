import 'package:flutter/material.dart';

import '../../model/constants.dart';
import '../../model/pokemon.dart';
import '../ui_helper.dart';

class DetailsPagePortrait extends StatefulWidget {
  final Pokemon pokemon;

  DetailsPagePortrait({this.pokemon});

  @override
  _DetailsPagePortraitState createState() => _DetailsPagePortraitState();
}

class _DetailsPagePortraitState extends State<DetailsPagePortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Pikachu n'est pas là !",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: bodyWidget(context),
    );
  }

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.12,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    widget.pokemon.name,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Taille: ${widget.pokemon.height}"),
                  Text("Poids: ${widget.pokemon.weight}"),
                  Column(
                    children: <Widget>[
                      Text(
                        "Types",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.pokemon.type
                            .map((t) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: FilterChip(
                                    pressElevation: 2.0,
                                    backgroundColor: Colors.amber,
                                    label: Text(t),
                                    onSelected: (b) {})))
                            .toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Faiblesses",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.pokemon.weaknesses
                            .map((t) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: FilterChip(
                                    pressElevation: 2.0,
                                    backgroundColor: Colors.red,
                                    label: Text(t,
                                        style: TextStyle(color: Colors.white)),
                                    onSelected: (b) {})))
                            .toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("Prochaine Evolution",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.pokemon.nextEvolution == null
                            ? <Widget>[Text("Ceci est la forme finale")]
                            : widget.pokemon.nextEvolution
                                .map((n) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: FilterChip(
                                        pressElevation: 2.0,
                                        backgroundColor: Colors.green,
                                        label: Text(n.name,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onSelected: (b) {})))
                                .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: UIHelper.isPortrait(ctx: context) ? Alignment.topCenter : Alignment.topLeft,
            child: Hero(
                tag: widget.pokemon.img,
                child: Container(
                  height: UIHelper.isPortrait(ctx: context) ? 150.0 : 200.0,
                  width: UIHelper.isPortrait(ctx: context) ? 150.0 : 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.pokemon.img))),
                )),
          )
        ],
      );

}

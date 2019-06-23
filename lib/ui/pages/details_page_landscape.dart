import 'package:flutter/material.dart';

import '../../model/constants.dart';
import '../../model/pokemon.dart';
import '../ui_helper.dart';

class DetailsPageLandscape extends StatefulWidget {
  final Pokemon pokemon;

  DetailsPageLandscape({this.pokemon});

  @override
  _DetailsPageLandscapeState createState() => _DetailsPageLandscapeState();
}

class _DetailsPageLandscapeState extends State<DetailsPageLandscape> {
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
                height: 10.0,
              ),
              Text(
                widget.pokemon.name,
                style:
                TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text("Taille: ${widget.pokemon.height}"),
              Text("Poids: ${widget.pokemon.weight}"),
              SizedBox(
                height: 3.0,
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
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

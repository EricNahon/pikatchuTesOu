import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:pikachutou/model/app_state.dart';
import '../../model/pokemon.dart';

class FoundPage extends StatefulWidget {
  FoundPage({@required this.pokemon, @required this.animRewardUrl});

  final Pokemon pokemon;
  final String animRewardUrl;

  @override
  _FoundPageState createState() => _FoundPageState();
}

class _FoundPageState extends State<FoundPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Bravo !', textAlign: TextAlign.center)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/pikachu.gif',
              fit: BoxFit.fill,
              width: 40.0,
              height: 40.0,
            ),
          ),
          Divider(height: 1.0),
          Expanded(
            flex: 3,
            child: Stack(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: appState.animRewardUrl,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

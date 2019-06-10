import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';

import 'package:pikachutou/model/constants.dart';
import 'package:pikachutou/model/app_state.dart';
import '../components/poke_quizz.dart';
import '../components/circular_progress.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.header}) : super(key: key);

  final String header;
  static AudioCache player = AudioCache();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

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
                  delegate: PokeSearch(pokeHub: appState.pokeDex),
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
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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

      body: appState.isFetching ? CircularProgress() : PokeQuizz(),
    );
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';

import '../../model/constants.dart';
import '../../model/app_state.dart';
import '../components/poke_quizz.dart';
import '../components/circular_progress.dart';
import 'about_page.dart';
import 'info_page.dart';

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

    GlobalKey bottomNavigationKey = GlobalKey();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      //AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          kTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          appState.fetchData();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: _getBody(appState.currentBottomTabIndex, appState.isFetching),
    );
  }

  Widget _getBody(int tabIndex, bool isFetching) {
    switch (tabIndex) {
      case 0:
        if (isFetching) {
          return CircularProgress();
        }
        return PokeQuizz();
      case 1:
        return AboutPage();
      default:
        return PokeQuizz();
    }
  }
}

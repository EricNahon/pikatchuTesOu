import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audio_cache.dart';

import '../thirdparty/fancybottomanim/fancy_bottom_navigation.dart';

import '../../model/constants.dart';
import '../../model/app_state.dart';
import '../components/poke_quizz.dart';
import '../components/circular_progress.dart';
import 'about_page.dart';

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
          widget.header,
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
              onPressed: () {},
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

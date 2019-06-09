import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pikachutou/app_state.dart';
import 'package:pikachutou/constants.dart';
import 'package:pikachutou/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AppState(),
      child: MaterialApp(
        title: kTitle,
        debugShowCheckedModeBanner: false,
        home: Home(
          header: kTitle,
        ),

        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
          accentColor: Colors.blue,
          textTheme: TextTheme(
            headline: TextStyle(
//              fontSize: 72.0,
//              fontWeight: FontWeight.bold,
            ),
            title: TextStyle(
//              fontSize: 36.0,
//              fontStyle: FontStyle.italic,
                color: Colors.black
            ),
            body1: TextStyle(
//              fontSize: 14.0,
//              fontFamily: 'Hind',
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}

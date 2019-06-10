import 'package:flutter/material.dart';

import '../../model/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('A propos')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'PikaTeOu',
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          Image.asset(
            'assets/images/ApitepBearLogo.png',
            fit: BoxFit.fitHeight,
            width: 120.0,
            height: 120.0,
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(child: Text("Made by Apitep", textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

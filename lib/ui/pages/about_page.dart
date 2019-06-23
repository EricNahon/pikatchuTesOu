import 'package:flutter/material.dart';

import '../../model/constants.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'PikaTeOu',
            style: kTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          Image.asset(
            'assets/images/ApitepBearLogo.png',
            fit: BoxFit.contain,
            width: 150.0,
            height: 150.0,
          ),
          SizedBox(
            height: 1.0,
          ),
          Center(child: Text("Made by Apitep", textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../../model/constants.dart';
import '../components/delayed_animation.dart';
import '../components/btn.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  int _counter = 0;

  final int delayedAmount = 400;
  double _scaleAnimation;
  AnimationController _controllerAnimation;

  @override
  void initState() {
    _controllerAnimation = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });

    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scaleAnimation = 1 - _controllerAnimation.value;

    return Scaffold(
      backgroundColor: kColorBlueMedincell,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            DelayedAimation(
              child: AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: kApitepLogo,
                      radius: 80.0,
                    )),
              ),
              delay: delayedAmount + 200,
            ),
            DelayedAimation(
              child: Text(
                "Mais où est-tu Pikachu ?",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0, color: color),
              ),
              delay: delayedAmount + 1000,
            ),
            SizedBox(
              height: 150.0,
            ),
            DelayedAimation(
              child: Btn(
                title: "Commencer",
                icon: kVictoryBadge,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
              delay: delayedAmount + 2100,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

}
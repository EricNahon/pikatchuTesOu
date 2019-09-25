import 'package:flutter/material.dart';
import '../../model/constants.dart';

class Btn extends StatelessWidget {
  final String title;
  final Widget icon;
  final double minWidth;
  final Function onTap;

  Btn(
      {Key key,
        this.title,
        this.icon,
        this.minWidth = 200.0,
        this.onTap,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: this.minWidth),
      child: FlatButton.icon(
        shape: StadiumBorder(),
        padding: EdgeInsets.all(10.0),
        color: kColorLightGray,
        textColor: kColorBlueMedincell,
        icon: this.icon,
        label: Text(
          title,
          style: TextStyle(
            color: kColorBlueMedincell,
            fontSize: 18.0,
          ),
        ),
        onPressed: this.onTap,
      ),
    );
  }
}
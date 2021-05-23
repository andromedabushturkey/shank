import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingActionButtonWidet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.remove,
      buttonSize: 56,
      visible: true,
      closeManually: false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: .5,
      onOpen: () => print('open dial'),
      onClose: () => print('close dial'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-tag',
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(AntIcons.dollar),
          backgroundColor: Colors.white,
          label: 'Daily Expense',
          labelStyle: TextStyle(fontSize: 18),
          onTap: () => print('test1'),
        ),
        SpeedDialChild(
          child: Icon(AntIcons.retweet_outline),
          backgroundColor: Colors.white,
          label: 'Recurring Expense',
          labelStyle: TextStyle(fontSize: 18),
          onTap: () => print('second child'),
        ),
        SpeedDialChild(
            child: Icon(AntIcons.credit_card_outline),
            backgroundColor: Colors.white,
            label: 'Credit Expense',
            labelStyle: TextStyle(fontSize: 18),
            onTap: () {
              print('credit test');
            })
      ],
    );
  }
}

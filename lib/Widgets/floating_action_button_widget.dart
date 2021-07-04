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
      backgroundColor: Colors.green[50],
      foregroundColor: Colors.black,
      elevation: 0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(
            AntIcons.dollar,
            color: Colors.black,
          ),
          backgroundColor: Colors.green[50],
          label: 'Daily Expense',
          labelBackgroundColor: Colors.green[50],
          labelStyle: TextStyle(fontSize: 18),
          onTap: () => print('test1'),
        ),
        SpeedDialChild(
          child: Icon(
            AntIcons.retweet_outline,
            color: Colors.black,
          ),
          labelBackgroundColor: Colors.green[50],
          backgroundColor: Colors.green[50],
          label: 'Recurring Expense',
          labelStyle: TextStyle(fontSize: 18),
          onTap: () => print('second child'),
        ),
        SpeedDialChild(
            child: Icon(
              AntIcons.credit_card_outline,
              color: Colors.black,
            ),
            backgroundColor: Colors.green[50],
            labelBackgroundColor: Colors.green[50],
            label: 'Credit Expense',
            labelStyle: TextStyle(
              fontSize: 18,
            ),
            onTap: () {
              print('credit test');
            })
      ],
    );
  }
}

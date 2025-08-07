import 'package:flutter/material.dart';
import 'package:treasure_of_aware/debug/debugger_button_widget.dart';
import 'package:treasure_of_aware/dialogs/treasure_alert/treature_alert_dialog.dart';
import 'package:treasure_of_aware/dialogs/treasure_success_alert/treasure_success_alert.dart';
import 'package:treasure_of_aware/layout/map/map_layout.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapLayout(),
          DebuggerButtonWidget(),
          // SafeArea(
          //   child: Align(
          //     alignment: Alignment.bottomLeft,
          //     child: FloatingActionButton(
          //       onPressed: () {
          //         TreasureSuccessAlert.show(context);
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

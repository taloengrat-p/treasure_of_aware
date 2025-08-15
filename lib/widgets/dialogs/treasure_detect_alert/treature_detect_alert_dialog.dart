import 'package:flutter/material.dart';
import 'package:treasure_of_aware/widgets/dialogs/treasure_detect_alert/widget/treasure_detect_alert_content.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

class TreatureDetectAlertDialog {
  static show(BuildContext context, {required Treasure treasure, required TreasureItem treasureItem}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: TreasureDetectAlertContent(treasure: treasure, treasureItem: treasureItem),
        );
      },
    );
  }
}

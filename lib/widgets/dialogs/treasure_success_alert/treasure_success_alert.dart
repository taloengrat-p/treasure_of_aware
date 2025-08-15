import 'package:flutter/material.dart';
import 'package:treasure_of_aware/widgets/dialogs/treasure_success_alert/widget/treasure_content.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

class TreasureSuccessAlert {
  static Future<bool?> show(BuildContext context, {required Treasure treasure, required TreasureItem treasureItem}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: TreasureContent(treasure: treasure, treasureItem: treasureItem),
        );
      },
    );
  }
}

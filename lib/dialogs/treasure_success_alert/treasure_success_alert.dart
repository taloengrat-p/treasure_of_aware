import 'package:flutter/material.dart';
import 'package:treasure_of_aware/dialogs/treasure_success_alert/widget/treasure_content.dart';

class TreasureSuccessAlert {
  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: TreasureContent(),
        );
      },
    );
  }
}

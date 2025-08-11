import 'package:flutter/material.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

class TreasureDetectAlertContent extends StatefulWidget {
  final Treasure treasure;
  final TreasureItem treasureItem;
  const TreasureDetectAlertContent({
    super.key,
    required this.treasure,
    required this.treasureItem,
  });

  @override
  _TreasureDetectAlertContentState createState() =>
      _TreasureDetectAlertContentState();
}

class _TreasureDetectAlertContentState
    extends State<TreasureDetectAlertContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      height: 500,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 24),
          Text(
            widget.treasure.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          Image.asset(widget.treasure.imageAsset, height: 140),
        ],
      ),
    );
  }
}

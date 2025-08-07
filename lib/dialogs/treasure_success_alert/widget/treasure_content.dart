import 'package:flutter/material.dart';

class TreasureContent extends StatefulWidget {
  const TreasureContent({Key? key}) : super(key: key);

  @override
  State<TreasureContent> createState() => _TreasureContentState();
}

class _TreasureContentState extends State<TreasureContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      height: 500,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class TreatureAlertDialog {
  static show(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Container(
          child: RippleAnimation(
            color: Colors.deepOrange,
            delay: const Duration(milliseconds: 300),
            repeat: true,
            minRadius: 75,
            maxRadius: 60,
            ripplesCount: 6,
            duration: const Duration(milliseconds: 6 * 300),
            child: CircleAvatar(minRadius: 75, maxRadius: 75),
          ),
        );
      },
    );
  }
}

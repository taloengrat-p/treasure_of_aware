import 'package:flutter/material.dart';

class OverlayLoading extends StatelessWidget {
  const OverlayLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54,
      child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
    );
  }
}

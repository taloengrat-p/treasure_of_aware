import 'package:flutter/material.dart';

class UserDebugWidget extends StatefulWidget {
  const UserDebugWidget({super.key});

  @override
  _UserDebugWidgetState createState() => _UserDebugWidgetState();
}

class _UserDebugWidgetState extends State<UserDebugWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: SingleChildScrollView(child: Column(children: [])),
    );
  }
}

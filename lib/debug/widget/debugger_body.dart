import 'package:flutter/material.dart';
import 'package:treasure_of_aware/debug/widget/treasure/treasure_debug_widget.dart';

class DebuggerBody extends StatefulWidget {
  const DebuggerBody({super.key});

  @override
  State<DebuggerBody> createState() => _DebuggerBodyState();
}

class _DebuggerBodyState extends State<DebuggerBody> {
  List<Widget> get items => [
    ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TreasureDebugWidget()),
        );
      },
      child: Text("Treasure list"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Debugger tool")),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(onTap: () {}, child: items.elementAt(index));
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: items.length,
      ),
    );
  }
}

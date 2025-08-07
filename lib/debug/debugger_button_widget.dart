import 'package:flutter/material.dart';
import 'package:treasure_of_aware/debug/widget/debugger_body.dart';

class DebuggerButtonWidget extends StatefulWidget {
  const DebuggerButtonWidget({Key? key}) : super(key: key);

  @override
  State<DebuggerButtonWidget> createState() => _DebuggerButtonWidgetState();
}

class _DebuggerButtonWidgetState extends State<DebuggerButtonWidget> {
  Offset position = Offset(16, 400);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: _buildBox(),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          setState(() {
            position = details.offset;
          });
        },
        child: _buildBox(),
      ),
    );
  }

  Widget _buildBox() {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const DebuggerBody()));
      },
      child: Icon(Icons.bug_report_outlined),
    );
  }
}

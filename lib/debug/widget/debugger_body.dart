import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treasure_of_aware/debug/cubit/debugger_cubit.dart';
import 'package:treasure_of_aware/debug/widget/treasure/treasure_debug_widget.dart';
import 'package:treasure_of_aware/debug/widget/user/user_debug_widget.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';

class DebuggerBody extends StatefulWidget {
  const DebuggerBody({super.key});

  @override
  State<DebuggerBody> createState() => _DebuggerBodyState();
}

class _DebuggerBodyState extends State<DebuggerBody> {
  late final DebuggerCubit cubit;
  late final MapLayoutCubit mapCubit;

  final _leadingController = TextEditingController();
  final _accuracyController = TextEditingController();

  @override
  void initState() {
    cubit = BlocProvider.of<DebuggerCubit>(context);
    mapCubit = BlocProvider.of<MapLayoutCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapLayoutCubit, MapLayoutState>(
      listener: (BuildContext context, MapLayoutState state) {
        if (state is MapLayoutUserLocationUpdate) {
          _leadingController.text = state.heading.toString();
          _accuracyController.text = state.accuracy.toString();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Debugger tool")),
        body: ListView(
          children: [
            BlocBuilder<DebuggerCubit, DebuggerState>(
              builder: (context, state) {
                return Switch.adaptive(
                  value: cubit.isDebugMode,
                  onChanged: (value) {
                    cubit.toggleDebugMode();
                  },
                );
              },
            ),
            Text("Latitude: ${mapCubit.currentPosition?.latitude}"),
            Text("Longitude: ${mapCubit.currentPosition?.longitude}"),
            TextField(
              controller: _leadingController,
              decoration: InputDecoration(label: Text("Leading")),
              onChanged: (value) {
                mapCubit.setCurrentHeading(double.tryParse(value));
              },
            ),
            TextField(
              controller: _accuracyController,
              decoration: InputDecoration(label: Text("Position accuration")),
              onChanged: (value) {
                mapCubit.setAcculacy(double.tryParse(value));
              },
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TreasureDebugWidget(),
                  ),
                );
              },
              child: Text("Treasure"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserDebugWidget(),
                  ),
                );
              },
              child: Text("User"),
            ),
          ],
        ),
      ),
    );
  }
}

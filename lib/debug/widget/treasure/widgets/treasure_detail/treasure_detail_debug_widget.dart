import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treasure_of_aware/debug/widget/treasure/widgets/treasure_detail/cubit/treasure_detail_debug_cubit.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';
import 'package:treasure_of_aware/layout/map/map_layout.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/screens/main_screen.dart';

class TreasureDetailDebugWidget extends StatefulWidget {
  final Treasure treasure;
  final List<TreasureItem> treasureItems;
  const TreasureDetailDebugWidget({required this.treasure, required this.treasureItems, super.key});

  @override
  _TreasureDetailDebugWidgetState createState() => _TreasureDetailDebugWidgetState();
}

class _TreasureDetailDebugWidgetState extends State<TreasureDetailDebugWidget> {
  late final TreasureDetailDebugCubit cubit;

  @override
  void initState() {
    cubit = TreasureDetailDebugCubit(treasure: widget.treasure, treasureItems: widget.treasureItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<TreasureDetailDebugCubit, TreasureDetailDebugState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Image.asset(cubit.treasure.imageAsset, height: 22),
                  SizedBox(width: 16),
                  Text(cubit.treasure.name),
                ],
              ),
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                final item = cubit.treasureItems[index];

                return ListTile(
                  title: Text(item.id),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Owner : ${item.owner}"),
                      Text("${item.direction} angle | height ${item.altitude} m"),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      BlocProvider.of<MapLayoutCubit>(context).flyTo(item.latlng);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: Icon(Icons.map_rounded),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: cubit.treasureItems.length,
            ),
          );
        },
      ),
    );
  }
}

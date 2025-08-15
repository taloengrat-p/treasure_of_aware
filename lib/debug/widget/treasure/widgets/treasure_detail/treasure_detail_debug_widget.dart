import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:treasure_of_aware/debug/widget/treasure/widgets/treasure_add/treasure_add_widget.dart';
import 'package:treasure_of_aware/debug/widget/treasure/widgets/treasure_detail/cubit/treasure_detail_debug_cubit.dart';
import 'package:treasure_of_aware/widgets/dialogs/treasure_success_alert/treasure_success_alert.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';

class TreasureDetailDebugWidget extends StatefulWidget {
  final Treasure treasure;
  final List<TreasureItem> treasureItems;
  const TreasureDetailDebugWidget({
    required this.treasure,
    required this.treasureItems,
    super.key,
  });

  @override
  _TreasureDetailDebugWidgetState createState() =>
      _TreasureDetailDebugWidgetState();
}

class _TreasureDetailDebugWidgetState extends State<TreasureDetailDebugWidget> {
  late final TreasureDetailDebugCubit cubit;

  @override
  void initState() {
    cubit = TreasureDetailDebugCubit(
      treasure: widget.treasure,
      treasureItems: widget.treasureItems,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<TreasureDetailDebugCubit, TreasureDetailDebugState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is TreasureDetailDebugLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    Image.asset(cubit.treasure.imageAsset, height: 22),
                    SizedBox(width: 16),
                    Text(cubit.treasure.name),
                  ],
                ),
                actions: [
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Add treasure'),
                        ),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TreasureAddWidget(treasure: widget.treasure),
                            ),
                          );

                          if (result) {
                            cubit.refresh();
                          }
                        },
                      ),
                      // PopupMenuItem(
                      //   child: ListTile(
                      //     leading: Icon(Icons.map),
                      //     title: Text('Map'),
                      //   ),
                      //   onTap: () {},
                      // ),
                    ],
                  ),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  cubit.refresh();
                },
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = cubit.treasureItems[index];

                    return ListTile(
                      title: Text(item.id),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Owner : ${item.owner}"),
                          Text(
                            item.location,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: Colors.amber),
                          ),
                          Text(
                            "${item.direction} angle | height ${item.altitude} m",
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<MapLayoutCubit>(
                                context,
                              ).flyTo(item.latlng);
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            },
                            child: Icon(Icons.map_rounded),
                          ),
                          SizedBox(height: 4),
                          InkWell(
                            onTap: () async {
                              if (item.owner == null) {
                                final result = await TreasureSuccessAlert.show(
                                  context,
                                  treasure: cubit.treasure,
                                  treasureItem: item,
                                );

                                if (result == true) {
                                  cubit.refresh();
                                }
                              } else {
                                cubit.removeOwner(item.id);
                              }
                            },
                            child: Icon(
                              item.owner == null
                                  ? Icons.inventory_2_rounded
                                  : Icons.delete_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cubit.treasureItems.length,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

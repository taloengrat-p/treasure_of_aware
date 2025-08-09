import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:treasure_of_aware/debug/widget/treasure/cubit/treasure_debug_cubit.dart';
import 'package:treasure_of_aware/debug/widget/treasure/widgets/treasure_detail/treasure_detail_debug_widget.dart';

class TreasureDebugWidget extends StatefulWidget {
  const TreasureDebugWidget({super.key});

  @override
  _TreasureDebugWidgetState createState() => _TreasureDebugWidgetState();
}

class _TreasureDebugWidgetState extends State<TreasureDebugWidget> {
  final cubit = TreasureDebugCubit();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Treasure"),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) => [PopupMenuItem(child: Text('Create'), onTap: () {})],
            ),
          ],
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            cubit.refresh();
          },
          child: BlocBuilder<TreasureDebugCubit, TreasureDebugState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state is TreasureDebugLoading,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = cubit.treasure[index];
                    final treasureItem = item.treasureItems(cubit.treasureItems);
                    return InkWell(
                      onTap: () {
                        if (treasureItem.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TreasureDetailDebugWidget(treasure: item, treasureItems: treasureItem),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        title: Text(item.name),
                        subtitle: Text("Amount : ${treasureItem.length}"),
                        trailing: treasureItem.isNotEmpty ? Icon(Icons.chevron_right_rounded) : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: cubit.treasure.length,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

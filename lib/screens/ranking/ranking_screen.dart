import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:treasure_of_aware/screens/main/main_screen.dart';
import 'package:treasure_of_aware/screens/ranking/cubit/ranking_cubit.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';
import 'package:treasure_of_aware/widgets/overlay_loading.dart';

class RankingScreen extends StatefulWidget {
  final bool showBottom;

  const RankingScreen({super.key, this.showBottom = true});

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final cubit = RankingCubit();

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
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: Text("Ranking")),
            body: RefreshIndicator.adaptive(
              onRefresh: () async {
                await cubit.refresh();
              },
              child: BlocBuilder<RankingCubit, RankingState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is RankingLoading,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final item = cubit.employees[index];
                        final totalPoint = item.totalPoint(
                          context.session.treasure,
                        );
                        return ListTile(
                          leading:
                              (index == 0 || index == 1 || index == 2) &&
                                  totalPoint != 0
                              ? Image.asset(
                                  index == 0
                                      ? "assets/images/first.png"
                                      : index == 1
                                      ? "assets/images/second.png"
                                      : "assets/images/third.png",
                                  height: 40,
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  child: Text(
                                    totalPoint != 0 ? "${index + 1}" : "-",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                          title: Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.star_circle_fill,
                                color: Colors.amber,
                              ),
                              Text(
                                totalPoint.toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: cubit.employees.length,
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: widget.showBottom
                ? SafeArea(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map_rounded, size: 28),
                            SizedBox(width: 8),
                            Text("Play Game"),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          BlocBuilder<RankingCubit, RankingState>(
            buildWhen: (previous, current) =>
                previous is RankingInitialLoading ||
                current is RankingInitialLoading,
            builder: (context, state) => Visibility(
              visible: state is RankingInitialLoading,
              child: OverlayLoading(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:treasure_of_aware/debug/widget/user/cubit/user_ranking_cubit.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';

class UserDebugWidget extends StatefulWidget {
  const UserDebugWidget({super.key});

  @override
  _UserDebugWidgetState createState() => _UserDebugWidgetState();
}

class _UserDebugWidgetState extends State<UserDebugWidget> {
  final cubit = UserRankingCubit();
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
        appBar: AppBar(title: Text("Users")),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            await cubit.refresh();
          },
          child: BlocBuilder<UserRankingCubit, UserRankingState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state is UserRankingLoading,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final item = cubit.employees[index];

                    return ListTile(
                      title: Text(item.name),
                      trailing: Text(
                        item.totalPoint(context.session.treasure).toString(),
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
      ),
    );
  }
}

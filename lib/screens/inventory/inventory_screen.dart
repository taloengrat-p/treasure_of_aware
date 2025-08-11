import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treasure_of_aware/screens/inventory/cubit/inventory_cubit.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  late final InventoryCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = InventoryCubit(
      employee: context.session.employee,
      employeeTreasureItem: context.session.employeeTreasureItem,
      treasureItem: context.session.treasure,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inventory")),
      body: BlocListener<SessionCubit, SessionState>(
        listener: (BuildContext context, SessionState state) {
          if (state is SessionInitialEmployeeSuccess) {
            cubit.refreshEmployee(state.empTreasureItems);
          }
        },
        child: BlocBuilder<SessionCubit, SessionState>(
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                context.session.refreshEmployee();
              },
              child: context.session.employeeTreasureItem.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SafeArea(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height - 80,
                              child: Text("Your inventory is empty"),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final item = cubit.treasureFilteredItem[index];

                        return ListTile(
                          leading: Image.asset(item.imageAsset, height: 28),
                          title: Text(item.name),
                          trailing: Text(
                            "x ${item.amount}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: cubit.treasureFilteredItem.length,
                    ),
            );
          },
        ),
      ),
    );
  }
}

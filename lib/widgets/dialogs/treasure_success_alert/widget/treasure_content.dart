import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treasure_of_aware/widgets/dialogs/treasure_success_alert/cubit/treasure_success_alert_cubit.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';

class TreasureContent extends StatefulWidget {
  final Treasure treasure;
  final TreasureItem treasureItem;

  const TreasureContent({super.key, required this.treasure, required this.treasureItem});

  @override
  State<TreasureContent> createState() => _TreasureContentState();
}

class _TreasureContentState extends State<TreasureContent> {
  final cubit = TreasureSuccessAlertCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<TreasureSuccessAlertCubit, TreasureSuccessAlertState>(
        listener: (context, state) {
          if (state is TreasureSuccessAlertSuccess) {
            Navigator.pop(context, true);
          }
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Colors.white),
          height: 500,
          width: double.infinity,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Text(widget.treasure.name, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 16),
                  Image.asset(widget.treasure.imageAsset, height: 140),
                ],
              ),
            ),
            bottomNavigationBar: BlocBuilder<TreasureSuccessAlertCubit, TreasureSuccessAlertState>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is TreasureSuccessAlertFailure) Text("${state.error.toString()}"),
                      ElevatedButton(
                        onPressed: state is TreasureSuccessAlertLoading
                            ? null
                            : () {
                                cubit.submit(widget.treasureItem.id, context.session.employee);
                              },
                        child: state is TreasureSuccessAlertLoading
                            ? CircularProgressIndicator.adaptive()
                            : Text("Claim"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

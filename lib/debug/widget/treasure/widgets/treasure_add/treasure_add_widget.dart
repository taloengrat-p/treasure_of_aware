import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/debug/widget/treasure/widgets/treasure_add/cubit/treasure_add_cubit.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';
import 'package:treasure_of_aware/layout/map/map_layout.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';
import 'package:treasure_of_aware/widgets/dialogs/confirm_dialog.dart';
import 'package:treasure_of_aware/widgets/overlay_loading.dart';

class TreasureAddWidget extends StatefulWidget {
  final Treasure treasure;
  const TreasureAddWidget({super.key, required this.treasure});

  @override
  _TreasureAddWidgetState createState() => _TreasureAddWidgetState();
}

class _TreasureAddWidgetState extends State<TreasureAddWidget> {
  GoogleMapController? _mapController;
  late final TreasureAddCubit cubit;
  late final MapLayoutCubit mapLayoutCubit;
  @override
  void initState() {
    cubit = TreasureAddCubit(treasure: widget.treasure);
    mapLayoutCubit = BlocProvider.of<MapLayoutCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<TreasureAddCubit, TreasureAddState>(
        listener: (context, state) {
          if (state is TreasureAddSuccess) {
            context.session.treasureItems.add(state.item);
            Navigator.pop(context, true);
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text(widget.treasure.name)),
          body: Stack(
            children: [
              MapLayout(
                showMarker: true,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onTap: (location) async {
                  final result = await ConfirmDialog.showConfirmDialog(
                    context: context,
                    title: "Confirm add",
                    content:
                        "location: ${location.latitude}, ${location.longitude}\naltitude: ${mapLayoutCubit.altitude}",
                  );

                  if (result == true) {
                    cubit.doAdd(location);
                  }
                },
              ),
              BlocBuilder<TreasureAddCubit, TreasureAddState>(
                builder: (context, state) {
                  if (state is TreasureAddLoading) {
                    return OverlayLoading();
                  }

                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/debug/widget/treasure/widgets/treasure_add/cubit/treasure_add_cubit.dart';
import 'package:treasure_of_aware/layout/map/map_layout.dart';
import 'package:treasure_of_aware/models/treasure.dart';
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
  @override
  void initState() {
    cubit = TreasureAddCubit(treasure: widget.treasure);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<TreasureAddCubit, TreasureAddState>(
        listener: (context, state) {
          if (state is TreasureAddSuccess) {
            Navigator.pop(context, true);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              MapLayout(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onTap: (p0) {
                  cubit.doAdd(p0);
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

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:treasure_of_aware/layout/map/cubit/map_layout_cubit.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/session/cubit/session_cubit.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final SessionCubit sessionCubit;
  final MapLayoutCubit mapLayoutCubit;
  bool isShowUnlockTreasure = false;
  MainCubit({required this.mapLayoutCubit, required this.sessionCubit})
    : super(MainInitial());

  void detectCloseToTreasureItem() {
    if (mapLayoutCubit.currentPosition == null) {
      return;
    }
    for (var item in sessionCubit.treasureItems) {
      double distance = Geolocator.distanceBetween(
        mapLayoutCubit.currentPosition!.latitude,
        mapLayoutCubit.currentPosition!.longitude,
        item.latitude,
        item.longitude,
      );

      if (distance <= sessionCubit.unlockDistance) {
        final treasureFounded = sessionCubit.getTreasureById(item.treasureId);
        if (treasureFounded != null) {
          emit(
            MainDetectedCloseToTreasure(
              treasure: treasureFounded,
              treasureItem: item,
            ),
          );
        }

        break;
      }
    }
  }

  void doHideUnlockTreasureItem() {
    isShowUnlockTreasure = false;
    emit(MainUnlockTreasure(isShowUnlockTreasure));
  }

  void doShowUnlockTreasureItem() {
    isShowUnlockTreasure = true;
    emit(MainUnlockTreasure(isShowUnlockTreasure));
  }
}

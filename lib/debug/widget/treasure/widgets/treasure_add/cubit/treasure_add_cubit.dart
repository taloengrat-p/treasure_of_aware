import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';

part 'treasure_add_state.dart';

class TreasureAddCubit extends Cubit<TreasureAddState> {
  final _treasureRepository = GetIt.I<TreasureRepository>();

  final Treasure treasure;

  TreasureAddCubit({required this.treasure}) : super(TreasureAddInitial());

  doAdd(LatLng location) async {
    try {
      emit(TreasureAddLoading());
      final payload = TreasureItem(
        id: "",
        location: "${location.latitude},${location.longitude}",
        altitude: 1,
        treasureId: treasure.id,
      );

      await _treasureRepository.addTreasure(payload);
      emit(TreasureAddSuccess());
    } catch (e) {
      emit(TreasureAddFailure());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';
part 'treasure_detail_debug_state.dart';

class TreasureDetailDebugCubit extends Cubit<TreasureDetailDebugState> {
  final Treasure treasure;
  List<TreasureItem> treasureItems;
  final _treasureRepository = GetIt.I<TreasureRepository>();
  TreasureDetailDebugCubit({
    required this.treasure,
    required this.treasureItems,
  }) : super(TreasureDetailDebugInitial());

  void removeOwner(String id) async {
    try {
      emit(TreasureDetailDebugLoading());
      await _treasureRepository.resetTreasureItemOwner(id);
      treasureItems = await _treasureRepository.getAllItemsByTreasureId(
        treasure.id,
      );
      emit(TreasureDetailDebugSuccess());
    } catch (e) {
      emit(TreasureDetailDebugFailure());
    }
  }

  void refresh() async {
    try {
      emit(TreasureDetailDebugLoading());
      treasureItems = await _treasureRepository.getAllItemsByTreasureId(
        treasure.id,
      );
      emit(TreasureDetailDebugSuccess());
    } catch (e) {
      emit(TreasureDetailDebugFailure());
    }
  }
}

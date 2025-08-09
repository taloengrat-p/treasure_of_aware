import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';

part 'treasure_debug_state.dart';

class TreasureDebugCubit extends Cubit<TreasureDebugState> {
  List<Treasure> treasure = [];
  List<TreasureItem> treasureItems = [];
  final treasureRepository = GetIt.I<TreasureRepository>();
  TreasureDebugCubit() : super(TreasureDebugInitial());

  void init() async {
    emit(TreasureDebugLoading());
    treasure = await treasureRepository.getAll();
    treasureItems = await treasureRepository.getAllItems();
    emit(TreasureDebugInitial());
  }

  void refresh() async {
    emit(TreasureDebugLoading());
    treasure = await treasureRepository.getAll();
    treasureItems = await treasureRepository.getAllItems();
    emit(TreasureDebugRefresh());
  }
}

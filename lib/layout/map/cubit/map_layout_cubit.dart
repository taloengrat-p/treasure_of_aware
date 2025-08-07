import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
import 'package:treasure_of_aware/repository/treasure/treasure_repository.dart';

part 'map_layout_state.dart';

class MapLayoutCubit extends Cubit<MapLayoutState> {
  final treasureRepository = GetIt.I<TreasureRepository>();

  List<Treasure> treasuries = [];
  List<TreasureItem> treasureItems = [];
  MapLayoutCubit() : super(MapLayoutInitial());

  init() async {
    emit(MapLayoutLoading());
    treasuries = await treasureRepository.getAll();
    treasureItems = await treasureRepository.getAllItems();

    emit(MapLayoutGetTreasureItemSuccess());
  }
}

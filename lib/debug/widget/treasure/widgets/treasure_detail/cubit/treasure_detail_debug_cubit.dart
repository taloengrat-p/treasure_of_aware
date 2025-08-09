import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:treasure_of_aware/models/treasure.dart';
import 'package:treasure_of_aware/models/treasure_item.dart';
part 'treasure_detail_debug_state.dart';

class TreasureDetailDebugCubit extends Cubit<TreasureDetailDebugState> {
  final Treasure treasure;
  final List<TreasureItem> treasureItems;

  TreasureDetailDebugCubit({required this.treasure, required this.treasureItems}) : super(TreasureDetailDebugInitial());
}

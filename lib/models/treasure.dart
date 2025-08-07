import "package:json_annotation/json_annotation.dart";

part "treasure.g.dart";

@JsonSerializable()
class Treasure {
  final String id;
  final String name;
  final int? amount;
  final String? image;

  Treasure({required this.id, required this.name, this.amount = 0, this.image});

  String get imageAsset {
    switch (image) {
      case "red":
        return "assets/images/10_red_gem.png";
      case "blue":
        return "assets/images/9_blue_gem.png";
      case "pink":
        return "assets/images/8_pink_gem.png";
      case "green":
        return "assets/images/7_green_gem.png";
      case "orange":
        return "assets/images/6_orange_gem.png";
      case "purple":
        return "assets/images/5_purple_gem.png";
      case "black":
        return "assets/images/4_purple_gem.png";
      case "yellow":
        return "assets/images/3_yellow_gem.png";
      case "brown":
        return "assets/images/2_brown_gem.png";
      case "white":
        return "assets/images/1_white_gem.png";
      default:
        return "assets/images/1_white_gem.png";
    }
  }

  factory Treasure.fromJson(Map<String, dynamic> json) =>
      _$TreasureFromJson(json);

  Map<String, dynamic> toJson() => _$TreasureToJson(this);
}

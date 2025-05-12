import 'package:assety/core/domain/entities/asset_category_entity.dart';
import 'package:assety/core/domain/entities/asset_entity.dart';

class TokenEntity extends AssetEntity {
  /// [logo] is an official icon of the token
  final String? logo;

  /// [symbol] is a shorthand code used to uniquely identify a particular asset in trading systems
  final String symbol;

  /// [dailyChange] shows how the price has changed over 24 hours as a percentage
  final double dailyChange;

  TokenEntity({
    required super.name,
    required super.price,
    required this.logo,
    required this.symbol,
    required this.dailyChange,
  }) : super(category: AssetCategoryEntity.cryptocurrency);
}
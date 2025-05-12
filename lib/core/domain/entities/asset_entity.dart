import 'package:assety/core/domain/entities/asset_category_entity.dart';

abstract class AssetEntity {
  final String name;
  final double price;
  final AssetCategoryEntity category;

  AssetEntity({
    required this.name,
    required this.price,
    required this.category,
  });
}

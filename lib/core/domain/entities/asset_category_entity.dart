class AssetCategoryEntity {
  static const cryptocurrency = AssetCategoryEntity._('Cryptocurrency');
  static const stock = AssetCategoryEntity._('Stock');
  static const commodity = AssetCategoryEntity._('Commodity');
  static const bond = AssetCategoryEntity._('Bond');
  static const forex = AssetCategoryEntity._('Forex');

  final String name;

  const AssetCategoryEntity._(this.name);

  factory AssetCategoryEntity.custom(String name) => AssetCategoryEntity._(name);

  @override
  String toString() => name;
}

class CategoryEntity {
  final int? id;
  final String name;

  CategoryEntity({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}

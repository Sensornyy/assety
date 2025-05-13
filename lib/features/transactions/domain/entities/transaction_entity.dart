import 'category_entity.dart';

class TransactionEntity {
  final int? id;
  final double amount;
  final String description;
  final bool isExpense;
  final CategoryEntity category;

  TransactionEntity({
    this.id,
    required this.amount,
    required this.description,
    required this.isExpense,
    required this.category,
  });

  // Method to convert TransactionEntity to a Map for SQL operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'is_expense': isExpense ? 1 : 0, // Store as 1 for true, 0 for false
      'category_id': category.id, // Store category ID in transactions
    };
  }

  // Factory to create TransactionEntity from a Map (used for database result mapping)
  factory TransactionEntity.fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map['id'] as int,
      amount: map['amount'] as double,
      description: map['description'] as String,
      isExpense: map['is_expense'] == 1,
      // Convert from 1/0 to bool
      category: CategoryEntity(
        id: map['cat_id'] as int,
        name: map['cat_name'] as String,
      ),
    );
  }
}

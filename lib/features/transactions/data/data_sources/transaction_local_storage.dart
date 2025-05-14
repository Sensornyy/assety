import 'package:assety/core/data/managers/database_manager.dart';
import 'package:assety/features/transactions/domain/entities/category_entity.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class TransactionLocalStorage {
  final DatabaseManager _databaseManager;

  TransactionLocalStorage(this._databaseManager);

  Future<List<TransactionEntity>> getAllTransactions() async {
    final db = await _databaseManager.database;
    final result = await db.rawQuery('''
    SELECT t.*, c.id as cat_id, c.name as cat_name
    FROM transactions t
    JOIN categories c ON t.category_id = c.id
    ORDER BY t.id DESC
  ''');

    return result.map((row) {
      return TransactionEntity.fromMap(row);
    }).toList();
  }

  Future<int> addTransaction(TransactionEntity transaction) async {
    final db = await _databaseManager.database;
    return await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeTransaction(int id) async {
    final db = await _databaseManager.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTransaction(TransactionEntity transaction) async {
    final db = await _databaseManager.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<List<CategoryEntity>> getAllCategories() async {
    final db = await _databaseManager.database;
    final result = await db.query('categories');

    return result.map((row) {
      return CategoryEntity.fromMap(row);
    }).toList();
  }

  Future<int> addCategory(CategoryEntity category) async {
    final db = await _databaseManager.database;
    return await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeCategory(int id) async {
    final db = await _databaseManager.database;
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateCategory(CategoryEntity category) async {
    final db = await _databaseManager.database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }
}

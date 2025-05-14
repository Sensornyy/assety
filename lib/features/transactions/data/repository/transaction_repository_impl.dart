import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/features/transactions/data/data_sources/transaction_local_storage.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';
import 'package:assety/features/transactions/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TransactionsRepository)
class TransactionRepositoryImpl implements TransactionsRepository {
  final TransactionLocalStorage _transactionLocalStorage;

  TransactionRepositoryImpl(this._transactionLocalStorage);

  @override
  Future<Result<void>> addTransaction(TransactionEntity transaction) async {
    try {
      await _transactionLocalStorage.addTransaction(transaction);
      return Result.success();
    } catch (e) {
      print(e);
      return Result.failure(errorMessage: 'Failed to add transaction: $e');
    }
  }

  @override
  Future<Result<void>> editTransaction(TransactionEntity transaction) async {
    try {
      await _transactionLocalStorage.updateTransaction(transaction);
      return Result.success();
    } catch (e) {
      return Result.failure(errorMessage: 'Failed to edit transaction: $e');
    }
  }

  @override
  Future<Result<List<TransactionEntity>>> getTransactions() async {
    try {
      final transactions = await _transactionLocalStorage.getAllTransactions();
      return Result.successWithData(transactions);
    } catch (e) {
      return Result.failure(errorMessage: 'Failed to get transactions: $e');
    }
  }

  @override
  Future<Result<void>> removeTransaction(int id) async {
    try {
      await _transactionLocalStorage.removeTransaction(id);
      return Result.success();
    } catch (e) {
      return Result.failure(errorMessage: 'Failed to remove transaction: $e');
    }
  }
}

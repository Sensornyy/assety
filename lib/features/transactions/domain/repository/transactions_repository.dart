import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';

abstract class TransactionsRepository {
  Future<Result<List<TransactionEntity>>> getTransactions();

  Future<Result<void>> editTransaction(TransactionEntity transaction);

  Future<Result<void>> addTransaction(TransactionEntity transaction);

  Future<Result<void>> removeTransaction(int id);
}

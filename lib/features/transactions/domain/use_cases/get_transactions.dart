import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';
import 'package:assety/features/transactions/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTransactionsUseCase {
  final TransactionsRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<Result<List<TransactionEntity>>> call() async {
    return await repository.getTransactions();
  }
}

import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';
import 'package:assety/features/transactions/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class EditTransactionUseCase {
  final TransactionsRepository repository;

  EditTransactionUseCase(this.repository);

  Future<Result<void>> call(TransactionEntity transaction) async {
    return await repository.editTransaction(transaction);
  }
}

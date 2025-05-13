import 'package:assety/core/data/error_handler/result.dart';
import 'package:assety/features/transactions/domain/repository/transactions_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class RemoveTransactionUseCase {
  final TransactionsRepository repository;

  RemoveTransactionUseCase(this.repository);

  Future<Result<void>> call(int id) async {
    return await repository.removeTransaction(id);
  }
}
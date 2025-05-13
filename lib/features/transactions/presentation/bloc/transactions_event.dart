part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class GetTransactions extends TransactionsEvent {}

final class AddTransaction extends TransactionsEvent {
  final TransactionEntity transaction;

  AddTransaction(this.transaction);
}

final class EditTransaction extends TransactionsEvent {
  final TransactionEntity transaction;

  EditTransaction(this.transaction);
}

final class RemoveTransaction extends TransactionsEvent {
  final int transactionId;

  RemoveTransaction(this.transactionId);
}

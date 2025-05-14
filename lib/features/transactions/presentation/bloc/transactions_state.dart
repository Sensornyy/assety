part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsLoading extends TransactionsState {}

final class TransactionsLoaded extends TransactionsState {
  final List<TransactionEntity> transactions;

  TransactionsLoaded(this.transactions);
}

final class TransactionsFailure extends TransactionsState {}

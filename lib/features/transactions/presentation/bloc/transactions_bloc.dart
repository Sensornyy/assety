import 'package:assety/core/di/init_di.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';
import 'package:assety/features/transactions/domain/use_cases/add_transaction_use_case.dart';
import 'package:assety/features/transactions/domain/use_cases/edit_transaction_use_case.dart';
import 'package:assety/features/transactions/domain/use_cases/get_transactions.dart';
import 'package:assety/features/transactions/domain/use_cases/remove_transaction_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final _getTransactionsUseCase = locator.get<GetTransactionsUseCase>();
  final _addTransactionUseCase = locator.get<AddTransactionUseCase>();
  final _editTransactionUseCase = locator.get<EditTransactionUseCase>();
  final _removeTransactionUseCase = locator.get<RemoveTransactionUseCase>();

  List<TransactionEntity> _transactionsCache = [];

  TransactionsBloc() : super(TransactionsInitial()) {
    on<GetTransactions>(_onGetTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<EditTransaction>(_onEditTransaction);
    on<RemoveTransaction>(_onRemoveTransaction);
  }

  // Handle fetching all transactions
  Future<void> _onGetTransactions(
    GetTransactions event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionsLoading());
    final result = await _getTransactionsUseCase();
    result.when(
      successWithData: (transactions) {
        _transactionsCache = transactions;
        emit(TransactionsLoaded(transactions));
      },
      failure: () {
        emit(TransactionsFailure());
        emit(TransactionsLoaded(_transactionsCache));
      },
    );
  }

  // Handle adding a new transaction
  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionsLoading());
    final result = await _addTransactionUseCase(event.transaction);
    result.when(
      success: () {
        _transactionsCache.add(event.transaction); // Add to the cached list
        emit(TransactionsLoaded(_transactionsCache));
      },
      failure: () => emit(TransactionsFailure()),
    );
  }

  // Handle editing an existing transaction
  Future<void> _onEditTransaction(
    EditTransaction event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionsLoading());
    final result = await _editTransactionUseCase(event.transaction);
    result.when(
      success: () {
        final index = _transactionsCache.indexWhere((tx) => tx.id == event.transaction.id);
        if (index != -1) {
          _transactionsCache[index] = event.transaction;
        }
        emit(TransactionsLoaded(_transactionsCache));
      },
      failure: () {
        emit(TransactionsFailure());
        emit(TransactionsLoaded(_transactionsCache));
      },
    );
  }

  Future<void> _onRemoveTransaction(
    RemoveTransaction event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionsLoading());
    final result = await _removeTransactionUseCase(event.transactionId);
    result.when(
      success: () {
        _transactionsCache.removeWhere((tx) => tx.id == event.transactionId);
        emit(TransactionsLoaded(_transactionsCache));
      },
      failure: () {
        emit(TransactionsFailure());
        emit(TransactionsLoaded(_transactionsCache));
      }
    );
  }
}

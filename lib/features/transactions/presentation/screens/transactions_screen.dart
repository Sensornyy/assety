import 'dart:math';

import 'package:assety/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:assety/features/transactions/presentation/widgets/balance_card.dart';
import 'package:assety/features/transactions/presentation/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TransactionsBloc _bloc = TransactionsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<TransactionsBloc>.value(
                  value: _bloc,
                  child: const AddTransactionScreen(),
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFF1E1E1E),
          child: const Icon(Icons.add, color: Colors.white,),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const BalanceCard(balance: 4250.80), // 💰 Верхній блок
              Expanded(
                child: BlocConsumer<TransactionsBloc, TransactionsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TransactionsLoaded) {
                      final transactions = state.transactions;
                      if (transactions.isEmpty) {
                        return Center(
                          child: Text(
                            'Список транзакцій пустий\nСтворіть нову, натиснувши +',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          final color = tx.isExpense ? Colors.red : Colors.green;
                          final icon = categoryIcons[tx.category.name] ?? Icons.category;

                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: color.withOpacity(0.2),
                                  child: Icon(icon, color: color, size: 24),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tx.description,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      (tx.isExpense ? '-₴' : '+₴') +
                                          tx.amount.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: color,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    tx.isExpense ? _buildAnomalyIcon(_getRandomAnomalyLevel()) ?? const SizedBox() : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnomalyLevel _getRandomAnomalyLevel() {
    final rand = Random();
    final levels = AnomalyLevel.values;
    return levels[rand.nextInt(levels.length)];
  }

  Widget? _buildAnomalyIcon(AnomalyLevel level) {
    switch (level) {
      case AnomalyLevel.weak:
        return const Icon(Icons.info_outline, color: Colors.yellow, size: 20);
      case AnomalyLevel.medium:
        return const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20);
      case AnomalyLevel.strong:
        return const Icon(Icons.dangerous_outlined, color: Colors.red, size: 20);
      case AnomalyLevel.none:
        return null;
    }
  }
}

const Map<String, IconData> categoryIcons = {
  'Продукти': Icons.fastfood,
  'Транспорт': Icons.directions_car,
  'Житло': Icons.home,
  'Розваги': Icons.movie,
  'Здоровʼя': Icons.local_hospital,
  'Покупки': Icons.shopping_cart,
  'Освіта': Icons.school,
  'Подорожі': Icons.flight,
  'Комуналка': Icons.lightbulb,
  'Зарплата': Icons.attach_money,
  'Інше': Icons.category,
};

import 'package:assety/features/transactions/presentation/bloc/transactions_bloc.dart';
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
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: BlocConsumer<TransactionsBloc, TransactionsState>(
            listener: (context, state) {},
            builder: (context, state) {
              print(state);

              if (state is TransactionsLoaded) {
                final transactions = state.transactions;

                if (transactions.isEmpty) {
                  return Center(
                    child: Text(
                      'Список транзакцій пустий\nСтворіть нову, натиснувши +',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    final icon = categoryIcons[tx.category.name] ?? Icons.category;

                    return ListTile(
                      leading: Icon(icon, color: tx.isExpense ? Colors.red : Colors.green),
                      title: Text(
                        '${tx.amount.toStringAsFixed(2)} UAH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tx.isExpense ? Colors.red : Colors.green,
                        ),
                      ),
                      subtitle: Text(tx.description),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
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

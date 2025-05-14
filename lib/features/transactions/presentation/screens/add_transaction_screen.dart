import 'dart:math';

import 'package:assety/features/transactions/domain/entities/category_entity.dart';
import 'package:assety/features/transactions/domain/entities/transaction_entity.dart';
import 'package:assety/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:assety/features/transactions/presentation/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

String _selectedCurrency = 'UAH';

final Map<String, String> currencySymbols = {
  'UAH': '₴',
  'USD': '\$',
  'EUR': '€',
  'GBP': '£',
};

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  bool _isExpense = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TransactionsBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Нова транзакція')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Сума'),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  items: currencySymbols.keys.map((code) {
                    return DropdownMenuItem(
                      value: code,
                      child: Text(currencySymbols[code]!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCurrency = value;
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Тип транзакції:'),
                DropdownButton<bool>(
                  value: _isExpense,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('Витрата')),
                    DropdownMenuItem(value: false, child: Text('Дохід')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _isExpense = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Категорія:'),
                DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Оберіть категорію'),
                  items: categoryIcons.keys.map((categoryName) {
                    return DropdownMenuItem(
                      value: categoryName,
                      child: Row(
                        children: [
                          Icon(categoryIcons[categoryName]),
                          const SizedBox(width: 8),
                          Text(categoryName),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Опис'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_amountController.text.isEmpty || _selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заповніть всі поля')),
                    );
                    return;
                  }
                  final random = Random();

                  final transaction = TransactionEntity(
                    amount: double.tryParse(_amountController.text) ?? 0.0,
                    description: _descriptionController.text,
                    isExpense: _isExpense,
                    category: CategoryEntity(id: random.nextInt(10000), name: _selectedCategory!),
                  );

                  bloc.add(AddTransaction(transaction));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Додати'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        title: const Text('Нова транзакція'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Сума + Валюта
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Сума',
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  dropdownColor: Colors.grey.shade900,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(),
                  items: currencySymbols.keys.map((code) {
                    return DropdownMenuItem(
                      value: code,
                      child: Text(
                        currencySymbols[code]!,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedCurrency = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Тип транзакції
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTypeButton(true, Icons.remove_circle, 'Витрата'),
                _buildTypeButton(false, Icons.add_circle, 'Дохід'),
              ],
            ),
            const SizedBox(height: 24),

            // Категорія
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Категорія',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Оберіть категорію', style: TextStyle(color: Colors.grey)),
                  dropdownColor: Colors.grey.shade900,
                  style: const TextStyle(color: Colors.white),
                  isExpanded: true,
                  items: categoryIcons.keys.map((name) {
                    return DropdownMenuItem(
                      value: name,
                      child: Row(
                        children: [
                          Icon(categoryIcons[name], color: Colors.white),
                          const SizedBox(width: 8),
                          Text(name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategory = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Опис
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Опис (необов’язково)',
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 36),

            // Кнопка
            // Кнопка "Додати" (оновлений стиль)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_amountController.text.isEmpty || _selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Заповніть всі обов’язкові поля')),
                    );
                    return;
                  }

                  final transaction = TransactionEntity(
                    amount: double.tryParse(_amountController.text) ?? 0.0,
                    description: _descriptionController.text,
                    isExpense: _isExpense,
                    category: CategoryEntity(
                      id: Random().nextInt(10000),
                      name: _selectedCategory!,
                    ),
                  );

                  bloc.add(AddTransaction(transaction));
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                label: const Text(
                  'Додати',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(bool isExpenseType, IconData icon, String label) {
    final isSelected = _isExpense == isExpenseType;
    return GestureDetector(
      onTap: () => setState(() => _isExpense = isExpenseType),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurpleAccent : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurpleAccent, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
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

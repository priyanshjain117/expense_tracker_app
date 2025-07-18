import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Text("Amount: "),
                    Icon(
                      Icons.currency_rupee_rounded,
                      size: 16.5,
                    ),
                    Text(expense.amount.toStringAsFixed(2)),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(expense.formatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

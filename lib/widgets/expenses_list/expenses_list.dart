import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.listExpenses, {super.key, required this.removeExpense});

  final void Function(Expense expense) removeExpense;
  final List<Expense> listExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExpenses.length,
      itemBuilder: (context, idx) => Dismissible(
          key: ValueKey(
            listExpenses[idx].id,
          ),
          onDismissed: (direction) {
            removeExpense(listExpenses[idx]);
          },
          child: ExpensesItem(listExpenses[idx])),
    );
  }
}

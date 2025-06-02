import 'package:flutter/material.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<ExpensesApp> {
  final List<Expense> _registeredExpenses = [
    //default for example..
    Expense(
      title: "title1",
      amount: 300,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "title2",
      amount: 601,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "title3",
      amount: 982,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    final Color? color = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).primaryColor.withOpacity(.95)
        : null;

    showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        clipBehavior: Clip.none,
        builder: (ctx) {
          return NewExpense(
            addExpense: _addExpense,
          );
        },
        backgroundColor: color,
        sheetAnimationStyle: AnimationStyle(
          duration: Duration(
            milliseconds: 350,
          ),
        ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final int expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(
          seconds: 3,
        ),
        content: const Text(
          "Expense deleted.",
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        // //styling
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
      ),
    );
  }

  String _deviceOrientation = "Unknown";
  
  @override
  void initState() {
    super.initState();
    accelerometerEventStream().listen((event) {
      if (event.x.abs() > event.y.abs()) {
        _deviceOrientation = event.x > 0 ? 'Landscape Left' : 'Landscape Right';
      } else {
        _deviceOrientation = event.y > 0 ? 'Portrait Down' : 'Portrait Up';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Container(
        margin: EdgeInsets.all(15),
        // alignment: Alignment.centerRight,
        child: Text(
          "No expenses found. Start adding some!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromRGBO(255, 243, 226, 0.686)
                    : const Color.fromARGB(167, 0, 0, 0),
              ),
        ),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    final width = MediaQuery.of(context).size.width;
// adjust for caera overlaping issue...
    var left = 0.0, right = 0.0;
    if (_deviceOrientation == 'Landscape Left') {
      right = MediaQuery.of(context).padding.right;
    } else if (_deviceOrientation == 'Landscape Right') {
      left = MediaQuery.of(context).padding.left;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                SizedBox(
                  height: 46.5,
                ),
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.only(
                left: left,
                right: right,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 46.5,
                  ),
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ),
            ),
    );
  }
}

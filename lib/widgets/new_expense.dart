import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  final Widget gap = const SizedBox(
    height: 20,
  );

  void _displayDatepicker() async {
    final lastDate = DateTime.now();
    final firstDate = DateTime(lastDate.year - 1);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _authenticateData() {
    final TextStyle errorStyle = TextStyle(
      color: Theme.of(context).colorScheme.onErrorContainer,
      fontWeight: FontWeight.w600,
    );
    final amount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        _selectedDate == null ||
        _selectedCategory == null ||
        amount == null ||
        amount < 0) {
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Column(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
                Text(
                  "Invalid Input!",
                  style: errorStyle,
                ),
              ],
            ),
            content: Text(
              "Please make sure all the entries are valid..",
              style: errorStyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  "OKAY",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              )
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext ctx) => AlertDialog(
            icon: Icon(
              Icons.warning_amber_rounded,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            title: Text(
              "Invalid Input!",
              style: errorStyle,
            ),
            content: Text(
              "Please make sure all the entries are valid..",
              style: errorStyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(
                  "OKAY",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              )
            ],
          ),
        );
      }
      return;
    }
    widget.addExpense(
      Expense(
        title: _titleController.text.trim(),
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

//Limit the scroll here!!
  @override
  Widget build(BuildContext context) {
    var overlap = MediaQuery.of(context).viewInsets.bottom;
    print(overlap);

    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        height: double.maxFinite,
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 55,
            //   width: double.infinity,
            // ),
            TextField(
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              keyboardType: TextInputType.name,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text("Title"),
              ),
            ),
            gap,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Adjust padding as needed
                        child: Icon(
                          Icons.currency_rupee_rounded,
                          size: 20.0,
                        ),
                      ),
                      label: Text("Amount"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                gap,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // TextButton.icon(
                      //   onPressed: _displayDatepicker,
                      //   icon: Icon(
                      //     Icons.calendar_month_outlined,
                      //   ),
                      //   label: const Text("Selected Date"),
                      // ),
                      Text(
                        _selectedDate == null
                            ? "No Date Selected"
                            : formatter.format(_selectedDate!),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      IconButton(
                        onPressed: _displayDatepicker,
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                  padding: EdgeInsets.all(3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  // menuMaxHeight: 120,
                  value: _selectedCategory,
                  hint: Text(
                    "Select a\nCategory: ",
                  ),
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null || value == _selectedCategory) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  dropdownColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(
                    right: 4,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                ElevatedButton(
                  onPressed: _authenticateData,
                  child: const Text("Save Expense"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

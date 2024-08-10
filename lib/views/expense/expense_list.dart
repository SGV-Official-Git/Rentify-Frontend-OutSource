import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/data/property_item_modal.dart';
import 'package:rentify/providers/expense_provider.dart';
import 'package:rentify/widgets/custom_app_bar.dart';

import '../../api/endpoints.dart';
import '../../widgets/expense_history.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  PropertyItem? propertyItem;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      propertyItem =
          ModalRoute.of(context)?.settings.arguments as PropertyItem?;
      context
          .read<ExpenseProvider>()
          .getExpenseList(propertyId: propertyItem?.id ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Expenses",
        automaticallyImplyLeading: true,
      ),
      body: Consumer<ExpenseProvider>(builder: (context, val, _) {
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: val.expenseList.length,
          itemBuilder: (context, index) => ExpenseHistory(
            amount: "${val.expenseList[index].expanseAmount ?? 0}",
            date: val.expenseList[index].expanseDate,
            image:
                "${Endpoints.imageUrl}${val.expenseList[index].expanseInvoice}",
            propertyName:
                val.expenseList[index].propertyDetails?.first.propertyName ??
                    "",
            title: val.expenseList[index].expanse,
          ),
        );
      }),
    );
  }
}

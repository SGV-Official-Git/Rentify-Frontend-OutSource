// ignore_for_file: use_build_context_synchronously, unused_field, prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/property_item_modal.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/expense_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/views/expense/add_expense.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/custom_button.dart';
import 'package:rentify/widgets/custom_text_field.dart';
import 'package:rentify/widgets/expense_history.dart';
import 'package:rentify/widgets/image.dart';
import 'package:rentify/widgets/total_deposite_widget.dart';

import '../../providers/properties_provider.dart';
import '../../providers/tenent_provider.dart';
import '../../widgets/property_dropdown.dart';
import '../../widgets/tap_widget.dart';
import 'property_list_dialog.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<String> _tabItem = ['All', 'Category Wise'];

  PropertyItem? property;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      property = context.read<PropertyProvider>().properties[0];
      setState(() {});
      await context
          .read<ExpenseProvider>()
          .getExpenseList(propertyId: property?.id ?? "");
      await context
          .read<ExpenseProvider>()
          .getExpenseData(propertyId: property?.id ?? "", type: "1");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: "Expense",
        actions: [
          TextButton(
              onPressed: () async {
                final data = await showModalBottomSheet(
                  context: context,
                  clipBehavior: Clip.hardEdge,
                  showDragHandle: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                  useRootNavigator: true,
                  backgroundColor: Colors.white,
                  builder: (context) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: AddExpense(property: property),
                  ),
                );

                log("kdfkjsdkfjsdkfjasdklfjsdfkjaksldfjsdklfjaskljfsdkl${data}");
                if (data) {
                  await context.read<PropertyProvider>().propertyListApi();
                  await context.read<ExpenseProvider>().getExpenseData(
                      propertyId: property?.id ?? "", type: "1");
                }
              },
              child: Text(
                "Add New",
                style: textStyle(
                    fontWeight: FontWeight.w500, color: AppColors.primary),
              ))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          InkWellWidget(
            onTap: () async {
              final property = await showDialog<PropertyItem>(
                context: context,
                builder: (context) => const PropertyListDialog(),
              );
              if (property != null) {
                this.property = property;
                setState(() {});
                await context
                    .read<TenantProvider>()
                    .getTenantList(propId: property.id);
                await context
                    .read<ExpenseProvider>()
                    .getExpenseList(propertyId: property.id ?? "");
              }
            },
            child: PropertyDropDown(
              property: property,
            ),
          ),
          SizedBox(
            height: dimensions.width * 0.05,
          ),
          TotalDepositeWidget(
            amount: "${property?.totalDepositAmount ?? 0}",
            icon: Assets.icons.navCollectionActive,
          ),
          SizedBox(
            height: dimensions.width * 0.05,
          ),
          Consumer<ExpenseProvider>(builder: (context, val, _) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$ ${val.expenseGraph?.totalSum}",
                        style: textStyle(
                            fontSize: dimensions.width * 0.05,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          ImageWidget(
                            url: Assets.icons.dropUp,
                            height: dimensions.width * 0.03,
                            width: dimensions.width * 0.03,
                          ),
                          SizedBox(width: dimensions.width * 0.02),
                          Text.rich(TextSpan(
                              text: "25% ",
                              style: textStyle(
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                    text: "Total Expense",
                                    style: textStyle(
                                        color: AppColors.bottomNav,
                                        fontWeight: FontWeight.w600))
                              ])),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: dimensions.width * 0.1,
                ),
                // Expanded(
                //   child: CustomTextField<String>(
                //     isDropdown: true,
                //     onChanged: (p0) {
                //       if (p0 == "Weekly") {
                //         context.read<ExpenseProvider>().getExpenseData(
                //             propertyId: property?.id ?? "", type: "1");
                //       } else {
                //         context.read<ExpenseProvider>().getExpenseData(
                //             propertyId: property?.id ?? "", type: "2");
                //       }
                //     },
                //     items: const ["Weekly", "Monthly"],
                //   ),
                // )
              ],
            );
          }),
          SizedBox(
            height: dimensions.width * 0.04,
          ),
          // Container(
          //   height: dimensions.width * 0.1,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: const Color(0xffF8F8F9)),
          //   child: Row(
          //     children: List.generate(
          //         _tabItem.length,
          //         (index) => Expanded(
          //               child: InkWellWidget(
          //                 onTap: () => setState(() {
          //                   _selectedTab = index;
          //                 }),
          //                 child: Container(
          //                   alignment: Alignment.center,
          //                   height: dimensions.width * 0.1,
          //                   decoration: _selectedTab == index
          //                       ? BoxDecoration(
          //                           color: Colors.white,
          //                           borderRadius: BorderRadius.circular(10),
          //                         )
          //                       : null,
          //                   child: Text(
          //                     _tabItem[index],
          //                     textAlign: TextAlign.center,
          //                   ),
          //                 ),
          //               ),
          //             )),
          //   ),
          // ),
          // SizedBox(
          //   height: dimensions.width * 0.04,
          // ),
          CustomButton(
            icon: Assets.icons.download,
            iconColor: Colors.white,
            title: "Financial Report",
          ),
          SizedBox(
            height: dimensions.width * 0.04,
          ),
          CustomButton(
            icon: Assets.icons.download,
            textColor: AppColors.primary.withOpacity(0.3),
            iconColor: AppColors.primary.withOpacity(0.3),
            backgroundColor: AppColors.lightButton,
            title: "Financial Report",
          ),
          SizedBox(height: dimensions.width * 0.03),
          const Divider(
            thickness: 4,
            color: Color(0xffF7F7F7),
          ),
          SizedBox(height: dimensions.width * 0.04),
          Row(
            children: [
              Expanded(
                child: Text(
                  "History",
                  style: textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: dimensions.width * 0.04),
                ),
              ),
              SizedBox(
                width: dimensions.width * 0.1,
              ),
              // Expanded(
              //   child: CustomTextField<String>(
              //     isDropdown: true,
              //     items: const ["Filter"],
              //     onChanged: (p0) {},
              //   ),
              // )
            ],
          ),
          SizedBox(height: dimensions.width * 0.03),
          Consumer<ExpenseProvider>(
            builder: (context, value, child) => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ExpenseHistory(
                      amount: "${value.expenseList[index].expanseAmount ?? 0}",
                      date: value.expenseList[index].expanseDate,
                      image:
                          "${Endpoints.imageUrl}${value.expenseList[index].expanseInvoice}",
                      propertyName: value.expenseList[index].propertyDetails
                              ?.first.propertyName ??
                          "",
                      title: value.expenseList[index].expanse,
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: value.expenseList.length),
          ),
          SizedBox(height: dimensions.width * 0.03),
          CustomButton(
            textColor: AppColors.primary,
            onPressed: () => AppNavigator.shared.pushNamed(
                routeName: Routes.expenseListScreen, arguments: property),
            backgroundColor: AppColors.lightButton,
            title: "See All",
          ),
        ],
      ),
    );
  }
}

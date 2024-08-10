// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/providers/expense_provider.dart';
import 'package:rentify/providers/properties_provider.dart';
import 'package:rentify/providers/tenent_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/utilities/keys.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/utilities/sp.dart';
import 'package:rentify/widgets/custom_button.dart';
import 'package:rentify/widgets/error_dialog.dart';
import 'package:rentify/widgets/expense_history.dart';
import 'package:rentify/widgets/tap_widget.dart';
import '../../data/home_grid_modal.dart';
import '../../data/property_item_modal.dart';
import '../../widgets/header_see_all.dart';
import '../../widgets/home_app_bar.dart';
import '../../widgets/home_grid_child.dart';
import '../../widgets/property_dropdown.dart';
import '../../widgets/rent_due_list_tile.dart';
import '../../widgets/tenant_list_tile.dart';
import 'property_list_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeGridModal> homeModal = [
    HomeGridModal(Assets.icons.properties, "Properties", Routes.propertiesList),
    HomeGridModal(Assets.icons.tenants, "Tenants", Routes.tenantListScreen),
    HomeGridModal(Assets.icons.collections, "Collection Due", ""),
    HomeGridModal(Assets.icons.expenses, "Expenses", Routes.expenseListScreen),
    HomeGridModal(Assets.icons.analytics, "Analytics", ""),
    HomeGridModal(Assets.icons.subscription, "Subscription", ""),
  ];
  final List<String> _tabItem = ['Tenant', 'Expense'];

  int _selectedTab = 0;

  PropertyItem? property;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<PropertyProvider>().propertyListApi();
      property = context.read<PropertyProvider>().properties[0];
      log("f;ljsd;fsd;lf;laf;;fljasdfj;lafhdfhsdjjkdfhdsjkh${property?.id}");
      setState(() {});
      await context.read<TenantProvider>().getTenantList(propId: property?.id);
      await context
          .read<ExpenseProvider>()
          .getExpenseList(propertyId: property?.id ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: SP.i.getString(key: SPKeys.userName),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        children: [
          InkWellWidget(
            onTap: () async {
              final property = await showDialog(
                context: context,
                builder: (context) => const PropertyListDialog(),
              );
              if (property != null) {
                this.property = property;
                setState(() {});
                await context
                    .read<TenantProvider>()
                    .getTenantList(propId: property?.id);
                await context
                    .read<ExpenseProvider>()
                    .getExpenseList(propertyId: property?.id ?? "");
              }
            },
            child: PropertyDropDown(
              property: property,
            ),
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 3),
            children: List.generate(
                homeModal.length,
                (index) => InkWellWidget(
                    onTap: () {
                      if (homeModal[index].route.isNotEmpty) {
                        AppNavigator.shared.pushNamed(
                            routeName: homeModal[index].route,
                            arguments: property);
                      } else {
                        alert(type: AlertType.info, message: "Coming Soon");
                      }
                    },
                    child: HomeGridChild(homeModal: homeModal[index]))),
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          const HeaderSeeAll(
            titleStart: "Rent Due",
            titleEnd: "See All",
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => InkWellWidget(
              child: RentDueListTile(
                image: Assets.images.propertyDetailImg.path,
                ownerName: "Jhon Doe",
                title: "Oakwood Villas",
                address: "456 Oakwood Ave, Townsville",
                date: DateTime.now(),
              ),
            ),
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          Container(
            height: dimensions.width * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffF8F8F9)),
            child: Row(
              children: List.generate(
                  _tabItem.length,
                  (index) => Expanded(
                        child: InkWellWidget(
                          onTap: () => setState(() {
                            _selectedTab = index;
                          }),
                          child: Container(
                            alignment: Alignment.center,
                            height: dimensions.width * 0.1,
                            decoration: _selectedTab == index
                                ? BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  )
                                : null,
                            child: Text(
                              _tabItem[index],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          if (_selectedTab == 0)
            Consumer<TenantProvider>(builder: (context, val, _) {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: val.tenantList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => TenantListTile(
                  image:
                      "${Endpoints.imageUrl}${val.tenantList[index].tenantImage}",
                  phone: val.tenantList[index].tenantMobileNo ?? "",
                  title: val.tenantList[index].tenantName ?? "",
                  address: val.tenantList[index].tenantPAddress ?? "",
                ),
              );
            }),
          if (_selectedTab == 1)
            Consumer<ExpenseProvider>(builder: (context, val, _) {
              return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: val.expenseList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ExpenseHistory(
                        amount: "${val.expenseList[index].expanseAmount ?? 0}",
                        date: val.expenseList[index].expanseDate,
                        image:
                            "${Endpoints.imageUrl}${val.expenseList[index].expanseInvoice}",
                        propertyName: val.expenseList[index].propertyDetails
                                ?.first.propertyName ??
                            "",
                        title: val.expenseList[index].expanse,
                      ));
            }),
          SizedBox(
            height: dimensions.width * 0.03,
          ),
          CustomButton(
            onPressed: () {
              if (_selectedTab == 0) {
                AppNavigator.shared.pushNamed(
                    routeName: Routes.tenantListScreen, arguments: property);
              } else {
                AppNavigator.shared.pushNamed(
                    routeName: Routes.expenseListScreen, arguments: property);
              }
            },
            backgroundColor: AppColors.lightButton,
            textColor: AppColors.primary,
            title: "See All",
          )
        ],
      ),
    );
  }
}

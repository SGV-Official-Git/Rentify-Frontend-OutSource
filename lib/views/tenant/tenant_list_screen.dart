import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/property_item_modal.dart';
import 'package:rentify/providers/tenent_provider.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/widgets/custom_app_bar.dart';
import 'package:rentify/widgets/tenant_list_tile.dart';

class TenantListScreen extends StatefulWidget {
  const TenantListScreen({super.key});

  @override
  State<TenantListScreen> createState() => _TenantListScreenState();
}

class _TenantListScreenState extends State<TenantListScreen> {
  PropertyItem? propertyItem;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final property =
          ModalRoute.of(context)?.settings.arguments as PropertyItem;
      propertyItem = property;
      setState(() {});
      context.read<TenantProvider>().getTenantList(propId: property.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tenants",
        actions: [
          TextButton(
              onPressed: () => AppNavigator.shared.pushNamed(
                  routeName: Routes.addNewTenants, arguments: propertyItem),
              child: Text(
                "Add New",
                style: textStyle(color: AppColors.primary),
              ))
        ],
      ),
      body: Consumer<TenantProvider>(
        builder: (context, value, child) => ListView.separated(
            itemBuilder: (context, index) => TenantListTile(
                  image:
                      "${Endpoints.imageUrl}${value.tenantList[index].tenantImage}",
                  address: value.tenantList[index].tenantPAddress ?? "",
                  phone: value.tenantList[index].tenantMobileNo ?? "",
                  title: value.tenantList[index].tenantName ?? "",
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: value.tenantList.length),
      ),
    );
  }
}

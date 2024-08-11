// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentify/api/endpoints.dart';
import 'package:rentify/data/tenant_item_modal.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/main.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/utilities/navigator.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/views/tenant/vacate_tenant.dart';
import 'package:rentify/widgets/image.dart';

class TenantProfile extends StatefulWidget {
  const TenantProfile({super.key});

  @override
  State<TenantProfile> createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile> {
  TenantItem? tenantDetail;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      tenantDetail = ModalRoute.of(context)?.settings.arguments as TenantItem;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF2F2F7)),
                    child: ImageWidget(
                      url: "${Endpoints.imageUrl}${tenantDetail?.tenantImage}",
                      height: dimensions.width * 0.5,
                      width: dimensions.width * 0.45,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: dimensions.height * 0.01,
                  ),
                  Text(
                    tenantDetail?.tenantName ?? '',
                    style: textStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: dimensions.width * 0.040,
                        color: AppColors.black),
                  ),
                  Text(
                    'Room: ${tenantDetail?.roomAllocated} • Bed: ${tenantDetail?.bedAllocated}',
                    style: textStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: dimensions.width * 0.035,
                        color: AppColors.black),
                  ),
                  const RentStatusWidget(),
                  SizedBox(
                    height: dimensions.height * 0.015,
                  )
                ],
              ),
            ),
            SizedBox(
              height: dimensions.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildButton(buttonText: 'SEE DOCUMENT')),
                SizedBox(
                  width: dimensions.width * 0.030,
                ),
                Expanded(child: _buildButton(buttonText: 'CALL TENANT')),
              ],
            ),
            SizedBox(
              height: dimensions.height * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purpose of stay:',
                  style: textStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.black),
                ),
                Text(
                  tenantDetail?.tPurposeofStay ?? '',
                  style: textStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.black),
                ),
                Text(
                  tenantDetail?.tenantMobileNo ?? '',
                  style: textStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.black),
                ),
                Text(
                  tenantDetail?.tenantPAddress ?? '',
                  style: textStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: dimensions.width * 0.035,
                      color: AppColors.black),
                ),
              ],
            ),
            SizedBox(
              height: dimensions.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: _buildButton(
                  buttonText: 'VACATE',
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      clipBehavior: Clip.hardEdge,
                      showDragHandle: true,
                      isScrollControlled: true,
                      useSafeArea: true,
                      useRootNavigator: true,
                      backgroundColor: Colors.white,
                      builder: (context) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: VacateTenant(),
                      ),
                    );
                  },
                )),
                SizedBox(
                  width: dimensions.width * 0.030,
                ),
                Expanded(child: _buildButton(buttonText: 'EDIT')),
                SizedBox(
                  width: dimensions.width * 0.030,
                ),
                Expanded(
                    child: _buildButton(
                  buttonText: 'COLLECT RENT',
                  onTap: () => AppNavigator.shared.pushNamed(
                    routeName: Routes.collectRentScreen,
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildButton({required String buttonText, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            buttonText,
            style: textStyle(
                fontWeight: FontWeight.w500,
                fontSize: dimensions.width * 0.03,
                color: AppColors.black),
          ),
        ),
      ),
    );
  }
}

class RentStatusWidget extends StatefulWidget {
  const RentStatusWidget({super.key});

  @override
  RentStatusWidgetState createState() => RentStatusWidgetState();
}

class RentStatusWidgetState extends State<RentStatusWidget> {
  int selectedIndex = 2; // Index of the selected month
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> monthList = [
    {"title": "Jan", "status": "Paid", "amount": "₹5000"},
    {"title": "Feb", "status": "Paid", "amount": "₹5000"},
    {"title": "Mar", "status": "Paid", "amount": "₹5000"},
    {"title": "Apr", "status": "Pending", "amount": "₹5000"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
  }

  void _scrollToSelectedIndex() {
    // Calculate the offset to scroll to the selected index
    double offset =
        (selectedIndex - 1) * (MediaQuery.of(context).size.width * 0.35);
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: dimensions.height * 0.02,
        ),
        Text(
          monthList[selectedIndex]['amount'],
          style: textStyle(
              fontWeight: FontWeight.w400,
              fontSize: dimensions.width * 0.070,
              color: AppColors.black),
        ),
        SvgPicture.asset(Assets.icons.polygon),
        SizedBox(
          height: dimensions.height * 0.01,
        ),
        SizedBox(
          height: dimensions.height * 0.09, // Fixed height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: monthList.length,
            itemBuilder: (context, index) {
              bool isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    _scrollToSelectedIndex();
                  });
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.3, // Adjust the width as needed
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF001064) : Color(0xFFF0EDE5),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          monthList[index]['title'],
                          style: textStyle(
                            fontSize: dimensions.width * 0.04,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          monthList[index]['status'],
                          style: textStyle(
                            color: isSelected ? Colors.orange : Colors.green,
                            fontSize: dimensions.width * 0.03,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

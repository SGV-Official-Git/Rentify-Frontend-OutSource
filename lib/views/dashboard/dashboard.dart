import 'package:flutter/material.dart';
import 'package:rentify/gen/assets.gen.dart';
import 'package:rentify/theme/colors.dart';
import 'package:rentify/theme/textstyles.dart';
import 'package:rentify/views/dashboard/collection.dart';
import 'package:rentify/views/dashboard/expense.dart';
import 'package:rentify/views/dashboard/home.dart';
import 'package:rentify/views/dashboard/profile.dart';
import 'package:rentify/widgets/image.dart';

import '../../data/bottom_nav_modal.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<BottomNavModal> bottomNavModal = [
    BottomNavModal(const Home(), Assets.icons.navHomeIcon, "Home"),
    BottomNavModal(
        const Collection(), Assets.icons.navCollection, "Collection"),
    BottomNavModal(const Expense(), Assets.icons.navExpense, "Expense"),
    BottomNavModal(const Profile(), Assets.icons.navProfile, "Profile")
  ];
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavModal[selectedTab].child,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTab,
          onTap: (value) => setState(() {
                selectedTab = value;
              }),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: textStyle(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w400,
              fontSize: 11),
          unselectedLabelStyle: textStyle(
              color: AppColors.bottomNav,
              fontWeight: FontWeight.w400,
              fontSize: 11),
          items: List.generate(
              bottomNavModal.length,
              (index) => BottomNavigationBarItem(
                  label: bottomNavModal[index].label,
                  icon: ImageWidget(
                    url: bottomNavModal[index].icon ?? "",
                    color: selectedTab == index
                        ? AppColors.primary
                        : AppColors.bottomNav,
                  )))),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rentify/main.dart';
import 'package:rentify/utilities/dimensions.dart';
import 'package:rentify/views/auth/login.dart';
import 'package:rentify/views/auth/otp_verify.dart';
import 'package:rentify/views/auth/register.dart';
import 'package:rentify/views/auth/splash.dart';
import 'package:rentify/views/properties/property_details.dart';
import 'package:rentify/views/tenant/collect_rent_screen.dart';
import 'package:rentify/views/tenant/tenant_list_screen.dart';
import 'package:rentify/views/tenant/tenant_profile_screen.dart';

import '../views/dashboard/dashboard.dart';
import '../views/expense/expense_list.dart';
import '../views/properties/add_new_property.dart';
import '../views/properties/property_list_screen.dart';
import '../views/tenant/add_new_tenant.dart';

class Routes {
  Routes._();
  static const splash = "/";
  static const login = "/login";
  static const register = "/register";
  static const dashboard = "/dashboard";
  static const addNewProperty = "/addNewProperty";
  static const propertyDetails = "/propertyDetails";
  static const addNewTenants = "/addNewTenants";
  static const otpVerify = "/otpVerify";
  static const propertiesList = "/propertiesList";
  static const tenantListScreen = "/tenantListScreen";
  static const expenseListScreen = "/expenseListScreen";
  static const tenantProfileScreen = "/tenantProfileScreen";
  static const collectRentScreen = "/collectRentScreen";

  static final routes = <String, WidgetBuilder>{
    splash: (context) => Builder(builder: (context) {
          dimensions = Dimensions(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width);
          return const Splash();
        }),
    login: (context) => const Login(),
    register: (context) => const Register(),
    dashboard: (context) => const Dashboard(),
    addNewProperty: (context) => const AddNewProperty(),
    propertyDetails: (context) => const PropertyDetails(),
    addNewTenants: (context) => const AddNewTenant(),
    otpVerify: (context) => const OtpVerify(),
    propertiesList: (context) => const PropertyListScreen(),
    tenantListScreen: (context) => const TenantListScreen(),
    tenantProfileScreen: (context) => const TenantProfile(),
    expenseListScreen: (context) => const ExpenseListScreen(),
    collectRentScreen: (context) => const CollectRent(),
  };
}

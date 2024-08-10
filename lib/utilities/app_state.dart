import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/expense_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/properties_provider.dart';
import '../providers/tenent_provider.dart';

class AppProviders {
  static final i = AppProviders();
  List<ChangeNotifierProvider> appProviders = [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
    ChangeNotifierProvider<PropertyProvider>(create: (_) => PropertyProvider()),
    ChangeNotifierProvider<TenantProvider>(create: (_) => TenantProvider()),
    ChangeNotifierProvider<ExpenseProvider>(create: (_) => ExpenseProvider()),
  ];
}

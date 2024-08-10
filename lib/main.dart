import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/api/api_manager.dart';
import 'package:rentify/firebase_options.dart';
import 'package:rentify/utilities/app_state.dart';
import 'package:rentify/utilities/routes.dart';
import 'package:rentify/utilities/sp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'utilities/dimensions.dart';
import 'utilities/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SP.i.init();
  await dotenv.load(fileName: '.env');
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  ApiManager.instance.init(dotenv.get("BASE_URL"));
  runApp(const MyApp());
}

Dimensions dimensions = Dimensions(height: 0, width: 0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.i.appProviders,
      builder: (context, child) => child!,
      child: ScaffoldMessenger(
        key: AppNavigator.shared.scaffoldMessangerKey,
        child: CupertinoApp(
          theme: const CupertinoThemeData(
              applyThemeToAll: true, scaffoldBackgroundColor: Colors.white),
          localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
          navigatorKey: AppNavigator.shared.navigatorKey,
          debugShowCheckedModeBanner: kDebugMode,
          routes: Routes.routes,
          initialRoute: Routes.splash,
        ),
      ),
    );
  }
}

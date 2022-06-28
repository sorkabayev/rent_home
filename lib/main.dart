import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rent_home/customer/view/pages/home/home_page.dart';
import 'package:rent_home/customer/viewmodel/providers/auth_provider.dart';
import 'package:rent_home/customer/viewmodel/providers/user_provider.dart';
import 'package:rent_home/models/user_model.dart';
import 'package:rent_home/services/auth_service.dart';
import 'package:rent_home/services/data_service.dart';
import 'package:rent_home/services/log_service.dart';
import 'package:provider/provider.dart';

import 'seller/views/seller_page_controller.dart';
import 'services/hive_service.dart';
import 'themes.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(HiveService.DB_NAME);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HiveService.box.clear();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final bool isDarkMode = false;

  checkUser(UserProvider userProvider, AuthProvider authProvider) {
    if (userProvider.user.id == null) {
      AuthService.signInAnonymous().then(
        (value) {
          Log.e("anonymous log");
          UserModel user = UserModel(id: value.uid, role: "anonymous");
          userProvider.setUser(user);
          HiveService.saveUser(user);
          FirestoreService.storeUser(user);
        },
      );
    }
    return authProvider.isSeller
        ? const SellerPageController()
        : const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    Log.d("Main page");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        StreamProvider(
          create: (context) => Connectivity().onConnectivityChanged,
          initialData: ConnectivityResult.none,
        ),
      ],
      builder: (context, _) {
        final userProvider = context.watch<UserProvider>();
        final authProvider = context.watch<AuthProvider>();
        Log.d("main page " + userProvider.user.toString());
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            title: 'Picco',
            debugShowCheckedModeBanner: false,
            theme: isDarkMode ? Themes().darkTheme : Themes().lightTheme,
            home: checkUser(userProvider, authProvider),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_app/pages/cart_page.dart';
import 'package:product_app/pages/home_page.dart';
import 'package:product_app/pages/product_page.dart';
import 'package:product_app/provider/product_provider.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(415, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.redAccent)),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            // home: SplashScreenPage(),
            routes: {
              ProductPage.routeName: (context) => ProductPage(),
              CartPage.routeName: (context) => CartPage(),
            },
          );
        });
  }
}

import 'package:auth_with_nodejs/auth/controller/auth_provider.dart';
import 'package:auth_with_nodejs/auth/login_page.dart';
import 'package:auth_with_nodejs/home/controller/home.dart';
import 'package:auth_with_nodejs/product/controller/product_add_or_edit_provider.dart';
import 'package:auth_with_nodejs/product/view/product_add_or_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ProductAddOrEditProvider>(
            create: (_) => ProductAddOrEditProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

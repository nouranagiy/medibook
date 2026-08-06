import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
class MediBookApp extends StatelessWidget {
  const MediBookApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "MediBook",
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
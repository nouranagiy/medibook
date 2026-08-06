import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medibook/core/services/service_locator.dart';
import 'package:medibook/features/auth/presentation/cubit/auth_cubit.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
class MediBookApp extends StatelessWidget {
  const MediBookApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "MediBook",
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
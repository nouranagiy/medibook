import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medibook/app/app_text_styles.dart';
import 'package:medibook/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medibook/features/auth/presentation/cubit/auth_state.dart';
import '../widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes/app_routes.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const SizedBox(height:60),
                Text(
                  "Welcome Back 👋",
                  style: AppTextStyles.heading1,
                ),
                const SizedBox(height:10),
                Text(
                  "Login to continue using MediBook",
                  style: AppTextStyles.body,
                ),
                const SizedBox(height:40),
                CustomTextField(
                  hint: "Email",
                  icon: Icons.email_outlined,
                  controller: emailController,
                  validator: (value){
                    if(value == null ||
                        value.isEmpty){
                      return "Please enter email";
                    }
                    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if(!emailRegex.hasMatch(value)){
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height:20),
                CustomTextField(
                  hint: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: (){
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  obscureText:true,
                  controller: passwordController,
                  validator:(value){
                    if(value == null ||
                        value.isEmpty){
                      return "Please enter password";
                    }
                    if(value.length < 6){
                      return "Password must be 6 characters";
                    }
                    return null;
                  },
                  icon: Icons.lock_outline,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){
                      debugPrint("Forgot Password");
                    },
                    child: Text(
                      "Forgot Password?",
                    ),
                  ),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                      if(state is AuthAuthenticated){
                        context.go(
                          AppRoutes.home,
                        );
                    }
                    if(state is AuthFailure){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(state.message,),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthLoading){
                      return const Center(
                        child:
                        CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!
                            .validate()){
                          context.read<AuthCubit>()
                              .login(
                            email:
                            emailController.text.trim(),
                            password:
                            passwordController.text.trim(),
                          );
                        }
                      },
                      child:
                      const Text(
                        "Login",
                      ),
                    );
                  },
                ),
                const SizedBox(height:5),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    const Text(
                        "Don't have an account?"
                    ),
                    TextButton(
                      onPressed: (){
                        context.push(AppRoutes.register);
                      },
                      child: const Text(
                        "Create Account",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
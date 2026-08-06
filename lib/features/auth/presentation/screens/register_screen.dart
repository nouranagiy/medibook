import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medibook/app/routes/app_routes.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/custom_text_field.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const SizedBox(height:60),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize:32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height:10),
                const Text(
                  "Register to start using MediBook",
                ),
                const SizedBox(height:40),
                CustomTextField(
                  hint: "Email",
                  icon: Icons.email_outlined,
                  controller: emailController,
                  validator:(value){
                    if(value == null ||
                        value.isEmpty){
                      return "Enter email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height:20),
                CustomTextField(
                  hint:"Password",
                  icon: Icons.lock_outline,
                  obscureText:true,
                  controller: passwordController,
                  validator:(value){
                    if(value == null ||
                        value.length < 6){
                      return "Password must be 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height:20),
                CustomTextField(
                  hint: "Confirm Password",
                  icon: Icons.lock_outline,
                  obscureText:true,
                  controller: confirmPasswordController,
                  validator:(value){
                    if(value !=
                        passwordController.text){
                      return "Passwords don't match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height:30),
                BlocConsumer<AuthCubit, AuthState>(
                  listener:(context,state){
                      if(state is AuthAuthenticated){
                        context.go(
                          AppRoutes.home,
                        );
                    }
                    if(state is AuthFailure){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content:
                          Text(state.message,),
                        ),
                      );
                    }
                  },
                  builder:(context,state){
                    if(state is AuthLoading){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed:(){
                        if(formKey.currentState!.validate()){context.read<AuthCubit>().register(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                        }
                      },
                      child:
                      const Text("Register"),
                    );
                  },
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
    confirmPasswordController.dispose();
    super.dispose();
  }
}
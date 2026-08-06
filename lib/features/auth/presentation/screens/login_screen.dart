import 'package:flutter/material.dart';
import 'package:medibook/app/app_text_styles.dart';
import '../widgets/custom_text_field.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
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
                  controller:
                  emailController,
                  validator: (value){
                    if(value == null ||
                        value.isEmpty){
                      return "Please enter email";
                    }
                    final emailRegex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: (){
                      setState(() {
                        isPasswordVisible =
                        !isPasswordVisible;
                      });
                    },
                  ),
                  obscureText:true,
                  controller:
                  passwordController,
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
                      debugPrint(
                          "Forgot Password"
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed:(){
                    if(formKey.currentState!
                        .validate()){
                      debugPrint(
                        "Login Success",
                      );
                    }
                  },
                  child:
                  const Text(
                    "Login",
                  ),
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
                        debugPrint(
                            "Register"
                        );
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
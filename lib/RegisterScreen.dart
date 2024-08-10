import 'package:cloudtestsupabase/authController.dart';
import 'package:cloudtestsupabase/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomTextField(
              hintText: 'Email',
              icon: Icons.email,
              onChanged: (value) {},
              con: emailController),
          CustomTextField(
              hintText: 'password',
              icon: Icons.password,
              onChanged: (value) {},
              con: passwordController),
          InkWell(
            onTap: () {
              ref.read(authControllerProvider.notifier).signup(
                  context, emailController.text, passwordController.text);
            },
            child: ref.watch(authControllerProvider)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

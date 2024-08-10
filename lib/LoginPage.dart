import 'package:cloudtestsupabase/RegisterScreen.dart';
import 'package:cloudtestsupabase/authController.dart';
import 'package:cloudtestsupabase/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailControler = TextEditingController();
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
              con: emailControler),
          CustomTextField(
              hintText: 'password',
              icon: Icons.password,
              onChanged: (value) {},
              con: passwordController),
          InkWell(
            onTap: () {
              ref.read(authControllerProvider.notifier).signin(
                  context, emailControler.text, passwordController.text);
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
                      "Log in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}

import 'package:cloudtestsupabase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dbCountriesFutureProvider = FutureProvider.autoDispose((ref) =>
    ref.watch(authControllerProvider.notifier).getdbCountriesEntries());


final dbLinuxFutureProvider = FutureProvider.autoDispose((ref) =>
    ref.watch(authControllerProvider.notifier).getdbLinuxEntries());

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(supabase: Supabase.instance));

class AuthController extends StateNotifier<bool> {
  final Supabase supabase;

  AuthController({required this.supabase}) : super(false);

  Future signin(BuildContext context, String email, String password) async {
    state = true;
    try {
      await supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Successfull login"),
        ));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Flutter')),
            (route) => false);
      }
    } on Exception catch (E) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(E.toString()),
        ));
      }
    } finally {
      state = false;
    }
  }

  Future signup(BuildContext context, String email, String password) async {
    state = true;
    try {
      await supabase.client.auth.signUp(email: email, password: password);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Verification link sent to you inbox"),
        ));
        Navigator.pop(context);
      }
    } on Exception catch (E) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(E.toString()),
        ));
      }
    } finally {
      state = false;
    }
  }

  Future signout(BuildContext context) async {
    state = true;
    try {
      await supabase.client.auth.signOut();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Logged out"),
        ));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(title: 'Flutter')),
            (route) => false);
      }
    } on Exception catch (E) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(E.toString()),
        ));
      }
    } finally {
      state = false;
    }
  }

  Future<List<Map<String, dynamic>>?> getdbCountriesEntries() async {
    return await supabase.client.from('countries').select();
  }

    Future<List<Map<String, dynamic>>?> getdbLinuxEntries() async {
    return await supabase.client.from('Linux').select();
  }
}

import 'package:cloudtestsupabase/authController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Signout extends ConsumerStatefulWidget {
  const Signout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignoutState();
}

class _SignoutState extends ConsumerState<Signout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                ref.invalidate(dbLinuxFutureProvider);
                ref.read(authControllerProvider.notifier).signout(context);
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
                        "SignOut",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

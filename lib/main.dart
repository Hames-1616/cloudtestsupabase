import 'package:cloudtestsupabase/LoginPage.dart';
import 'package:cloudtestsupabase/Signout.dart';
import 'package:cloudtestsupabase/authController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'http://192.168.29.45:54321',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
    realtimeClientOptions: const RealtimeClientOptions(eventsPerSecond: 2),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();

    final supabase = Supabase.instance.client;
    supabase
        .channel('countries')
        .onPostgresChanges(
            event: PostgresChangeEvent.insert,
            table: 'countries',
            schema: 'public',
            callback: (value) {
              // ignore: unused_result
              ref.refresh(dbCountriesFutureProvider);
            })
        .subscribe();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: unused_result
      ref.refresh(dbLinuxFutureProvider);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ref.watch(dbCountriesFutureProvider).when(
                  data: (data) {
                    if (data != [] && data != null) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          final country = data[index];
                          return ListTile(
                            title: Text(country['name']),
                          );
                        }),
                      );
                    } else {
                      return Container();
                    }
                  },
                  error: (error, st) {
                    return Container();
                  },
                  loading: () => const CircularProgressIndicator()),
            ),
            Expanded(
              child: ref.watch(dbLinuxFutureProvider).when(
                  data: (data) {
                    if (data != [] && data != null) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          final country = data[index];
                          return ListTile(
                            title: Text(country['name']),
                          );
                        }),
                      );
                    } else {
                      return Container();
                    }
                  },
                  error: (error, st) {
                    return Container();
                  },
                  loading: () => const CircularProgressIndicator()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Supabase.instance.client.auth.currentSession == null
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()))
              : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Signout()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.account_circle_rounded),
      ),
    );
  }
}

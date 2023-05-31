import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/screens/default_page.dart';
import 'package:kwtd/screens/home.dart';
import 'package:kwtd/screens/mentor_screens/mentor_home.dart';
import 'package:kwtd/screens/setup_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:kwtd/themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  final authStateProvider = StreamProvider<User?>((ref) {
    return FirebaseAuth.instance.authStateChanges();
  });

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'KWTD - Know What To Do',
      theme: lightTheme(),
      home: authState.when(
        data: (data) {
          if (data == null) {
            return const DefaultPage();
          } else {
            String? name = FirebaseAuth.instance.currentUser!.displayName;
            if (name == null || name == '') {
              return const AccountSetup();
            }
            return const HomePage();
          }
        },
        error: (e, trace) {},
        loading: () {},
      ),
    );
  }
}

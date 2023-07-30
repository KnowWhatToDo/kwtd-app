import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwtd/screens/default_page.dart';
import 'package:kwtd/screens/home.dart';
import 'package:kwtd/screens/setup_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:kwtd/themes/light_theme.dart';

/* 
Note to the mantainer this:
The app attempts to always access the locall stored data using LocalStorage
packages as visible in pubspect.yaml.
In the event that the data is not available, the app makes an API
request to get the data, by design multiple features of the app are built this
way to improve the performance and reducing the number of API calls.
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  // loading .env file to access the ip address of the server
  await dotenv.load(fileName: 'assets/.env');

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
  if (kDebugMode) {
    // the set test value gets printed to confirm that env file available
    print(dotenv.get('TEST_VALUE'));
  }
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

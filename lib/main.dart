import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:users/firebase_options.dart';
import 'package:users/home.dart';
import 'package:users/splashscreen.dart';
import 'package:users/userprofile.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        final Uri uri = Uri.parse(settings.name ?? '/');
        if (uri.pathSegments.isNotEmpty &&
            uri.pathSegments[0] == 'userProfile' &&
            uri.pathSegments.length > 1) {
          final String id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (context) => UserProfile(id: id),
          );
        }
        if (settings.name == 'home') {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }
        // Fallback route
        // return MaterialPageRoute(builder: (context) => const Splashscreen());
      },
      onUnknownRoute: (settings) {
        print('Unknown route: ${settings.name}');
        return MaterialPageRoute(builder: (context) => const Splashscreen());
      },
    );
  }
}

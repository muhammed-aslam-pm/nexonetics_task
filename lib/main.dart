import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/firebase_options.dart';
import 'package:nexonetics_task/view/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())],
      builder: (context, child) => const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

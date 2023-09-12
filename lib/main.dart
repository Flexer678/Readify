import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readify/pages/mainpage.dart';
import 'package:readify/provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Handler())]));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: MainPage());
  }
}

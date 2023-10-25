import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readify/pages/mainpage.dart';
import 'package:readify/provider/notification_provider.dart';
import 'package:readify/provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationProvider().initNotification();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderHandler())],
    child: MyApp(),
  ));
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

var important;

/// Adds [item] to cart. This and [removeAll] are the only ways to modify the
//note, network images do not load when debugging
//the thing will not load until you exited the app
//https://pub.dev/packages/mocktail_image_network
//thats the link(scroll all the way to the bottom) it says you cant
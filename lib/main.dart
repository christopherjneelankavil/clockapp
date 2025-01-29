import 'package:clockapp/enums.dart';
import 'package:clockapp/home_page.dart';
import 'package:clockapp/menu_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
      home: ChangeNotifierProvider<MenuInformation>(
        create: (context) => MenuInformation(MenuType.clock, title: 'Clock', imgSrc: 'lib/assets/clock_icon.png'),
        child: const HomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

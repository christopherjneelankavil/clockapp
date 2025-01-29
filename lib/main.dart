import 'package:clockapp/enums.dart';
import 'package:clockapp/home_page.dart';
import 'package:clockapp/menu_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'alarm_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmAdapter());
  await Hive.openBox<Alarm>('alarms');
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

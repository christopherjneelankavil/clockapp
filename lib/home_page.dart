import 'package:clockapp/menu_information.dart';
import 'package:clockapp/view_clock.dart';
import 'package:clockapp/alarm_view.dart';
import 'package:clockapp/timer_view.dart';
import 'package:clockapp/stopwatch_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'enums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var menuInfo = Provider.of<MenuInformation>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildMenuBtn('Clock', 'lib/assets/clock_icon.png', MenuType.clock),
              buildMenuBtn('Alarm', 'lib/assets/alarm_icon.png', MenuType.alarm),
              buildMenuBtn('Timer', 'lib/assets/timer_icon.png', MenuType.timer),
              buildMenuBtn('Stopwatch', 'lib/assets/stopwatch_icon.png', MenuType.stopwatch),
            ],
          ),
          const VerticalDivider(
            color: Color.fromARGB(255, 184, 174, 174),
            width: 2,
          ),
          Expanded(
            child: _getCurrentView(menuInfo.currentMenu),
          ),
        ],
      ),
    );
  }

  Widget _getCurrentView(MenuType currentMenu) {
    switch (currentMenu) {
      case MenuType.clock:
        return ClockView();
      case MenuType.alarm:
        return AlarmView();
      case MenuType.timer:
        return TimerView();
      case MenuType.stopwatch:
        return StopwatchView();
      default:
        return ClockView();
    }
  }

  Widget buildMenuBtn(String title, String image, MenuType type) {
    return Consumer<MenuInformation>(
      builder: (context, menuInfo, child) {
        return TextButton(
          onPressed: () => menuInfo.updateMenu(type, title, image),
          style: ButtonStyle(
            backgroundColor: menuInfo.currentMenu == type
                ? const WidgetStatePropertyAll(Colors.redAccent)
                : const WidgetStatePropertyAll(Colors.transparent),
            fixedSize: WidgetStateProperty.all<Size>(
              Size.fromWidth(MediaQuery.of(context).size.width / 4.5),
            ),
            padding: const WidgetStatePropertyAll(EdgeInsets.fromLTRB(16, 10, 10, 16)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
          ),
          child: Column(
            children: <Widget>[
              Image.asset(image, scale: 1.5),
              const SizedBox(height: 16),
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'PassionOne')),
            ],
          ),
        );
      },
    );
  }
}

class ClockView extends StatelessWidget {
  const ClockView({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattime = DateFormat('HH:mm').format(now);
    var formatdate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = now.timeZoneOffset.isNegative ? '' : '+';

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ... Keep existing clock view components ...
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Align(
              alignment: Alignment.center,
              child: ViewClock(
                size: MediaQuery.of(context).size.height / 3,
              ),
            ),
          ),
          // ... Rest of clock view ...
        ],
      ),
    );
  }
}
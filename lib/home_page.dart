import 'package:auto_size_text/auto_size_text.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = constraints.maxHeight > constraints.maxWidth;

            return Row(
              children: <Widget>[
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildMenuBtn('Clock', 'lib/assets/clock_icon.png', MenuType.clock, isPortrait),
                      _buildMenuBtn('Alarm', 'lib/assets/alarm_icon.png', MenuType.alarm, isPortrait),
                      _buildMenuBtn('Timer', 'lib/assets/timer_icon.png', MenuType.timer, isPortrait),
                      _buildMenuBtn('Stopwatch', 'lib/assets/stopwatch_icon.png', MenuType.stopwatch, isPortrait),
                    ],
                  ),
                ),
                const VerticalDivider(
                  color: Color.fromARGB(255, 184, 174, 174),
                  width: 2,
                ),
                Expanded(
                  child: Consumer<MenuInformation>(
                    builder: (context, menuInfo, _) => _getCurrentView(menuInfo.currentMenu),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  Widget _getCurrentView(MenuType currentMenu) {
    switch (currentMenu) {
      case MenuType.clock:
        return const ClockView();
      case MenuType.alarm:
        return AlarmView();
      case MenuType.timer:
        return TimerView();
      case MenuType.stopwatch:
        return const StopwatchView();
      default:
        return const ClockView();
    }
  }

  Widget _buildMenuBtn(String title, String image, MenuType type, bool isPortrait) {
    return Consumer<MenuInformation>(
      builder: (context, menuInfo, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final btnWidth = isPortrait ? screenWidth / 4.5 : screenWidth / 6;

        return TextButton(
          onPressed: () => menuInfo.updateMenu(type, title, image),
          style: ButtonStyle(
            backgroundColor: menuInfo.currentMenu == type
                ? const WidgetStatePropertyAll(Colors.redAccent)
                : const WidgetStatePropertyAll(Colors.transparent),
            fixedSize: WidgetStateProperty.all<Size>(Size(btnWidth, btnWidth)),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'PassionOne'
                  ),
                ),
              ),
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
    final now = DateTime.now();
    final formattime = DateFormat('HH:mm').format(now);
    final formatdate = DateFormat('EEE, d MMM').format(now);
    final timezoneString = now.timeZoneOffset.toString().split('.').first;
    final offsetSign = now.timeZoneOffset.isNegative ? '' : '+';

    return LayoutBuilder(
        builder: (context, constraints) {
          final isSmallScreen = constraints.maxWidth < 400;

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 32,
                vertical: 16
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Clock',
                      style: TextStyle(
                          fontSize: isSmallScreen ? 20 : 24,
                          color: Colors.white,
                          fontFamily: 'LibreBaskerville',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        formattime,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: isSmallScreen ? 48 : 64,
                            color: Colors.white,
                            fontFamily: 'LibreBaskerville',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      AutoSizeText(
                        formatdate,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 20,
                          color: Colors.white,
                          fontFamily: 'LibreBaskerville',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ViewClock(
                        size: constraints.maxWidth * 0.8,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Timezone',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 20 : 24,
                            color: Colors.white,
                            fontFamily: 'LibreBaskerville',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.language, color: Colors.white),
                          const SizedBox(width: 8),
                          AutoSizeText(
                            "UTC $offsetSign$timezoneString",
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 18 : 24,
                              fontFamily: 'LibreBaskerville',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
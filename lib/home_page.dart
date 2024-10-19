import 'package:clockapp/view_clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key}); 
  

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    

    var now = DateTime.now();
    var formattime = DateFormat('HH:mm').format(now);
    var formatdate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
    }

    print(timezoneString);

    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildMenuBtn('Clock', 'lib/assets/clock_icon.png'),
              buildMenuBtn('Alarm', 'lib/assets/alarm_icon.png'),
              buildMenuBtn('Timer', 'lib/assets/timer_icon.png'),
              buildMenuBtn('Stopwatch', 'lib/assets/stopwatch_icon.png'),
            ],
          ),
          //creating a divider between the column and the container
          const VerticalDivider(
            color: Color.fromARGB(255, 184, 174, 174),
            width: 2,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      'Clock',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'LibreBaskerville',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattime,
                          style: const TextStyle(
                              fontSize: 64,
                              color: Colors.white,
                              fontFamily: 'LibreBaskerville',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatdate,
                          style: const TextStyle(
                              fontSize: 20,
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
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: ViewClock(
                        size: MediaQuery.of(context).size.height/3,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Timezone',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'LibreBaskerville',
                              fontWeight: FontWeight.bold,),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.language,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "UTC $offsetSign$timezoneString",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
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
            ),
          ),
        ],
      ),
    );
  }
  

  Widget buildMenuBtn(String title, String image) {
    MediaQueryData m = MediaQuery.of(context);
    Size size=m.size;
    double scrnWidth=size.width;

    return TextButton(
      
      
      onPressed: () {},
      //adding color
    
      style:  ButtonStyle(
        backgroundColor:title=='Clock' ? const MaterialStatePropertyAll(Colors.redAccent):const MaterialStatePropertyAll(Colors.transparent),
    
        fixedSize: MaterialStateProperty.all<Size>(
          Size.fromWidth(scrnWidth/4.5),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.fromLTRB(16, 10, 10, 16)
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
        )
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            scale: 1.5,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'PassionOne'),
          ),
        ],
      ),
    );
  }
}

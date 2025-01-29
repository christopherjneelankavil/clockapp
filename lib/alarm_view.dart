import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmView extends StatefulWidget {
  @override
  _AlarmViewState createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  final List<Alarm> _alarms = [];
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (picked != null) {
                  setState(() {
                    _alarms.add(Alarm(time: picked, active: true));
                  });
                }
              },
              child: Text('Add Alarm'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _alarms.length,
                itemBuilder: (context, index) {
                  final alarm = _alarms[index];
                  return ListTile(
                    title: Text(DateFormat.Hm().format(DateTime(2023, 1, 1, alarm.time.hour, alarm.time.minute))),
                    trailing: Switch(
                      value: alarm.active,
                      onChanged: (value) {
                        setState(() {
                          alarm.active = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Alarm {
  TimeOfDay time;
  bool active;

  Alarm({required this.time, required this.active});
}
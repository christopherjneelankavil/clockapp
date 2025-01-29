import 'dart:async';

import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  Duration _duration = Duration(minutes: 30);
  bool _isRunning = false;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);
        } else {
          _timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    setState(() => _isRunning = false);
  }

  @override
  Widget build(BuildContext context) {
    String formatDuration(Duration d) =>
        '${d.inHours}:${(d.inMinutes % 60).toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatDuration(_duration),
          style: TextStyle(fontSize: 48, color: Colors.white),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isRunning)
              ElevatedButton(
                onPressed: _startTimer,
                child: Text('Start'),
              ),
            if (_isRunning)
              ElevatedButton(
                onPressed: _pauseTimer,
                child: Text('Pause'),
              ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _duration = Duration(minutes: 30);
                  _isRunning = false;
                });
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}
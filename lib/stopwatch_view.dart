import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  _StopwatchViewState createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  final Stopwatch _stopwatch = Stopwatch();
  final List<String> _laps = [];
  late Timer _timer;

  void _updateTime() {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000).toString().padLeft(3, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatDuration(_stopwatch.elapsed),
          style: const TextStyle(fontSize: 48, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_stopwatch.isRunning) {
                    _stopwatch.stop();
                    _timer.cancel();
                  } else {
                    _stopwatch.start();
                    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) => _updateTime());
                  }
                });
              },
              child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                if (_stopwatch.isRunning) {
                  setState(() {
                    _laps.add(_formatDuration(_stopwatch.elapsed));
                  });
                }
              },
              child: const Text('Lap'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _stopwatch.reset();
                  _laps.clear();
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _laps.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('Lap ${index + 1}: ${_laps[index]}',
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
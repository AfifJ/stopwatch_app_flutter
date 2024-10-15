import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  String time = "00:00:00";
  late Timer _timer = Timer(Duration.zero, () {});

  void _startTimeout() {
    /*Timer(_timeout, _handleTimeout);*/
    _timer = Timer.periodic(Duration(microseconds: 1), (timer) {
      if (_stopwatch.isRunning) {
        _startTimeout();
        setState(() {
          time = _getTime();
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _startStopwatch() {
    _stopwatch.start();
    _startTimeout();
  }

  void _stopStopwatch() {
    _stopwatch.stop();
  }

  void _resetStopwatch() {
    _stopStopwatch();
    _stopwatch.reset();
    setState(() {
      time = _getTime();
    });
  }

  String _getTime() {
    final Duration duration = _stopwatch.elapsed;
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = duration.inSeconds.toString().padLeft(2, '0');
    String milliseconds = (duration.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');

    if (hours != "00") return "$hours:$minutes:$seconds:$milliseconds";
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(time),
            MaterialButton(
              onPressed: _startStopwatch,
              child: Text("Start"),
            ),
            MaterialButton(
              onPressed: _stopStopwatch,
              child: Text("Stop"),
            ),
            MaterialButton(
              onPressed: _resetStopwatch,
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}

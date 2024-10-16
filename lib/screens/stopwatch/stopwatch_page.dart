import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  String _time = "00:00:00";
  bool _isRunning = false;
  Timer? _timer;

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
    });
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      setState(() {
        _time = _getTime();
      });
    });
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
    });
    _stopwatch.stop();
    _timer?.cancel();
  }

  void _resetStopwatch() {
    _stopStopwatch();
    setState(() {
      _stopwatch.reset();
      _time = _getTime();
    });
  }

  String _getTime() {
    final Duration duration = _stopwatch.elapsed;
    final int hundreds = (duration.inMilliseconds / 10).truncate();
    final int seconds = hundreds ~/ 100;
    final int minutes = seconds ~/ 60;
    final int hours = minutes ~/ 60;

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    if (hours > 0) {
      return "$hoursStr:$minutesStr:$secondsStr.$hundredsStr";
    } else {
      return "$minutesStr:$secondsStr.$hundredsStr";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Stopwatch"),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _time,
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                    onPressed: _isRunning ? _stopStopwatch : _startStopwatch,
                    color: _isRunning ? Colors.red : Colors.yellow[600]!,
                    text: _isRunning ? 'STOP' : 'START',
                    textColor: Colors.black),
                const SizedBox(width: 20),
                _buildButton(
                    onPressed: _resetStopwatch,
                    color: Colors.grey[700]!,
                    text: 'RESET',
                    textColor: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required Color color,
    Color? textColor,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: textColor),
      ),
    );
  }
}

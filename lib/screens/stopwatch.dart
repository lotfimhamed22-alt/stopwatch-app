import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  List<String> Laps = [];

  // formate timer
  String _formateTimer(int milliseconds) {
    int minutes = milliseconds ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int milli = (milliseconds % 1000) ~/ 10;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milli.toString().padLeft(2, '0')}";
  }

  bool isStopWatchRunning = false;
  late Timer globalTimer;
  int stopWatchCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // the counter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 180.0),
              child: Text(
                _formateTimer(stopWatchCounter),
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // bottoms
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // reset
                  GestureDetector(
                    onTap: () {
                      if (isStopWatchRunning == false) {
                        Laps = [];
                        setState(() {
                          stopWatchCounter = 0;
                        });
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[800],
                      ),
                      child: Text(
                        isStopWatchRunning ? "Lap" : "Reset",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // start
                  GestureDetector(
                    onTap: () {
                      if (isStopWatchRunning == false) {
                        setState(() {
                          isStopWatchRunning = true;
                        });
                        globalTimer = Timer.periodic(
                          Duration(milliseconds: 1),
                          (duration) {
                            setState(() {
                              stopWatchCounter++;
                            });
                          },
                        );
                      } else {
                        globalTimer.cancel();
                        setState(() {
                          isStopWatchRunning = false;
                        });
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 3, 80, 6),
                      ),
                      child: Text(
                        isStopWatchRunning ? "Stop" : "Start",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(221, 0, 206, 7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Laps
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: Laps.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(height: 2, color: Colors.grey[800]),
                  );
                },
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lap ${index + 1}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        Laps.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
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

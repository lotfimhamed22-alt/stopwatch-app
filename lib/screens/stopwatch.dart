import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  List<String> laps = [];

  // formate timer
  String _formateTimer(int milliseconds) {
    int minutes = milliseconds ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int milli = (milliseconds % 1000) ~/ 10;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milli.toString().padLeft(2, '0')}";
  }

  bool isStopWatchRunning = false;
  late Timer globalTimer;
  late Timer lapTimer;
  int stopWatchCounter = 0;
  int lapCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // the counter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 130.0),
              child: Text(
                _formateTimer(stopWatchCounter),
                style: TextStyle(
                  fontSize: 65,
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
                        setState(() {
                          laps = [];
                          stopWatchCounter = 0;
                          lapCounter = 0;
                        });
                      } else {
                        laps.add(_formateTimer(lapCounter));
                        setState(() {
                          lapCounter = 0;
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
                        // globalTimer
                        globalTimer = Timer.periodic(
                          Duration(milliseconds: 1),
                          (duration) {
                            setState(() {
                              stopWatchCounter++;
                            });
                          },
                        );
                        // lapTimer
                        lapTimer = Timer.periodic(Duration(milliseconds: 1), (
                          duration,
                        ) {
                          setState(() {
                            lapCounter++;
                          });
                        });
                      } else {
                        globalTimer.cancel();
                        lapTimer.cancel();

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
            SizedBox(
              height: 430,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Visibility(
                          visible:
                              isStopWatchRunning == true || lapCounter != 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap ${laps.length + 1}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _formateTimer(lapCounter),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Visibility(
                          visible:
                              isStopWatchRunning == true || lapCounter != 0,
                          child: Divider(height: 2, color: Colors.grey[800]),
                        ),
                      ),
                      ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        itemCount: laps.length,
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                laps[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

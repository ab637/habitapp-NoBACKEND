import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habitapp/habit_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List habitList = [
    [ 'Exercise', false, 0, 1   ],
    [ 'Read', false, 0, 10 ],
    [ 'Meditate', false, 0, 10 ],
    [ 'Code', false, 0, 10 ],




  ];
  void habitStarted(int index)
  {
    // note what tthe start time is 
     var startTime = DateTime.now();

// include the elapsed time

    int elaspedTime = habitList[index][2];
    setState(() {
      // habit status
      habitList[index][1]=!habitList[index][1];
    });
    // keep the time going and put a timer that never stops
    if(habitList[index][1]==true){
      Timer.periodic( const Duration(seconds: 1), (timer) {
        setState(() {
          if (!habitList[index][1]){
            timer.cancel();
          }
          //calulate the time elpased by finding out the difference between two times
          var currentTime  = DateTime.now();
          habitList[index][2]= elaspedTime + currentTime.second - startTime.second + (currentTime.minute-startTime.minute)*60 +
              ( currentTime.hour - startTime.hour)*3600;
        });
      });
    }

  }
  void settingsOpened(int index)
  {
    showDialog(context: context, builder: (context)
    {
      return AlertDialog(
        title: Text('settings for ' + habitList[index][0]),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title:const  Text('Consistency is the key'),
          centerTitle: false,
        ),
        body: ListView.builder( itemCount: habitList.length,
            itemBuilder: ((context, index){
          return HabitTile(habitName: habitList[index][0],
              onTap: (){
            habitStarted(index);
              },
              settingsTapped: (){
            settingsOpened(index);
          },
            habitStarted: habitList[index][1],

            timeGoal: habitList[index][3],
              timeSpent: habitList[index][2],
          );
        }

        ))


      ),
    );
  }
}


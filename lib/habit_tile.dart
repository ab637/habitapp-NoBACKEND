import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
final bool habitStarted;
  const HabitTile({Key? key, required this.habitName, required this.onTap, required this.settingsTapped,
    required this.timeGoal,
    required this.timeSpent,
    required this.habitStarted
  }) : super(key: key);
String formatToMinSec( int totalSeconds)
{
  String secs = (totalSeconds % 60).toString();
  String mins = (totalSeconds/60).toStringAsFixed(5);
  if(secs.length==1)
    {
      secs = '0'+secs;
    }
  if(mins[1]=='.')
    {
      mins = mins.substring(0,1);
    }

  return mins + ':' + secs;
;}
  double percentCompleted(){
  return timeSpent/(timeGoal*60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container( 
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),


        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ Row(children: [
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                height: 60,
                  width: 60,
                child: Stack(
                  children: [
                    Center(child: Icon( habitStarted ? Icons.pause: Icons.play_arrow)),
                    Center(child: CircularPercentIndicator(radius: 20
                    , percent: percentCompleted() < 1 ? percentCompleted(): 1
                      ,
                    progressColor: percentCompleted()>0.5 ? Colors.green: Colors.red )),
                  ]
                ),

              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(habitName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

                const SizedBox(height: 5,),
                Text(formatToMinSec(timeSpent)+'/'+ timeGoal.toString() + '=' + (percentCompleted()*100).toStringAsFixed(0) + '%',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey[500])),
              ],
            ),

          ],),

          GestureDetector( onTap: settingsTapped,
              child: Icon(Icons.settings)),
        ],),
      ),
    );
  }
}

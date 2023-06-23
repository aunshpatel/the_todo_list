import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_todo_list/screens/widgets/task_tile.dart';

import '../../consts.dart';

/*class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TaskTile(),
        // TaskTile(),
        // TaskTile(),
      ],
    );
  }
}*/

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> with TickerProviderStateMixin{
  late AnimationController animationController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:Firebase.initializeApp(),
      builder: (context, snapshot){
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if(snapshot.hasData){
          return ListView(
            children: [
              TaskTile(),
            ],
          );
        }
        //return Center(child: CircularProgressIndicator());
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              //valueColor: AlwaysStoppedAnimation<Color>(kThemeBlueColor),
              backgroundColor: kThemeBlueColor,
              strokeWidth: 4.0,
              color: Colors.white,
              valueColor: animationController
                  .drive(ColorTween(begin: Colors.blueAccent, end: kThemeBlueColor)),
              //backgroundColor: Colors.white,
            ),
          ),
        );
      }
    );
  }
}
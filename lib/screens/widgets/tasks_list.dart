import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_todo_list/screens/widgets/task_tile.dart';

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

class _TasksListState extends State<TasksList> {
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
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}
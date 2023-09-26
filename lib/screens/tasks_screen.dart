import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_todo_list/screens/widgets/tasks_list.dart';
import '../consts.dart';
import 'add_task_screen.dart';
import 'widgets/side_drawer.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
      child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot){
            return SafeArea(
              child:Scaffold(
                backgroundColor: kThemeBlueColor,
                drawer: MyDrawer(),
                appBar: AppBar(
                  backgroundColor: kThemeBlueColor,
                  elevation: 0,
                  leading: Builder(
                      builder: (BuildContext context){
                        return IconButton(
                          color: kWhiteColor,
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                        );
                      }
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: kThemeBlueColor,
                  foregroundColor: kWhiteColor,
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_task_screen');
                    // showModalBottomSheet(
                    //   context: context,
                    //   // isScrollControlled: true,
                    //   builder: (context)=> AddTasksScreen(),
                    // );
                  },
                  child: const Icon(Icons.add),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top:60.0,left:30.0,right:30.0,bottom:30.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Task List Screen', style: TextStyle(color:kWhiteColor, fontSize: 30.0, fontWeight: FontWeight.w700),),
                          //Text('${tasksLength.toString()} Tasks', style: TextStyle(color:kWhiteColor, fontSize: 18),),
                        ],
                      ),
                    ),
                    //List
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: const BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                          ),
                          child: TasksList(),
                        )
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}

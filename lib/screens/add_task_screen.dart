import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../consts.dart';

class AddTasksScreen extends StatefulWidget {
  const AddTasksScreen({super.key});

  @override
  State<AddTasksScreen> createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  @override
  final addTask = FirebaseFirestore.instance;
  TextEditingController addTaskTitleController = TextEditingController();
  TextEditingController addTaskDescrController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
    keyboardBarColor: Colors.grey[200],
    nextFocus: true,
    actions: [
      KeyboardActionsItem(
        focusNode: _nodeText1,
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "DONE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        ],
      ),
    ],
  );
}

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kWhiteColor,
          endDrawerEnableOpenDragGesture: false,
          // drawer: MyDrawer(),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back, color: kWhiteColor,),
                  onPressed: () {
                    Navigator.pushNamed(context, '/task_screen');
                  },
                );
              },
            ),
            actions: <Widget>[

            ],
            centerTitle: true,
            title: const Text('Add Task', style: TextStyle(color: kWhiteColor),),
            backgroundColor: kThemeBlueColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color:kWhiteColor,
                borderRadius: BorderRadius.only(topRight:Radius.circular(20.0),topLeft:Radius.circular(20.0),),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                      'Add a new task and description below',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        fontSize: 24,
                        color: kThemeBlueColor,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  const SizedBox(height:20.0),
                  TextField(
                    controller: addTaskTitleController,
                    focusNode: _nodeText1,
                    autofocus: true,
                    cursorColor: kThemeBlueColor,
                    decoration: const InputDecoration(
                        hintText: 'Please enter a title for the task'
                    ),
                  ),
                  const SizedBox(height:20.0),
                  TextField(
                    maxLines: 8,
                    controller: addTaskDescrController,
                    cursorColor: kThemeBlueColor,
                    decoration: const InputDecoration(
                        hintText: 'Please enter description for the task'
                    ),
                  ),
                  const SizedBox(height:20.0),
                  ElevatedButton(
                    onPressed: (){
                      if(addTaskTitleController.text.isNotEmpty){
                        addTask.collection('taskData').add({'task':addTaskTitleController.text,'description':addTaskDescrController.text, 'taskCreationDate':DateTime.now(),'isTaskComplete':false, 'user':currentUser});
                        Navigator.pushNamed(context, '/task_screen');
                      }
                      else{
                        _showMyDialog();
                      }
                    },
                    child: const Text('Add', style: TextStyle(color: kWhiteColor),),
                    style: ElevatedButton.styleFrom(backgroundColor: kThemeBlueColor),
                  ),
                ],
              ),
            ),
          )
        )
    );
  }

  Future _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!', style: TextStyle(color: kThemeBlueColor,fontSize: 20.0)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have added no title. Please make sure to add at least the title before pressing the add button.', style: TextStyle(color: kThemeBlueColor,fontSize: 20.0)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

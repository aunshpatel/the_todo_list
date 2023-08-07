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
  final addTask = FirebaseFirestore.instance;
  TextEditingController addTaskController = TextEditingController();
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
            //button 2
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF757575),
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
                'Add Task',
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontSize: 30,
                  color: kThemeBlueColor,
                  fontWeight: FontWeight.bold,
                )
              ),
              TextField(
                controller: addTaskController,
                focusNode: _nodeText1,
                autofocus: true,
                cursorColor: kThemeBlueColor,
              ),
              SizedBox(height:10.0),
              ElevatedButton(
                onPressed: (){
                  if(addTaskController.text.isNotEmpty){
                    addTask.collection('taskData').add({'task':addTaskController.text, 'taskCreationDate':DateTime.now(),'isTaskComplete':false, 'user':currentUser});
                    Navigator.pop(context);
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
        )
    );
  }


  Future _showMyDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!', style: TextStyle(color: kThemeBlueColor)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have added no text. Please add text before pressing the add button.', style: TextStyle(color: kThemeBlueColor)),
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
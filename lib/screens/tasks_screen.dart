import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../consts.dart';
import 'widgets/side_drawer.dart';
import 'package:lottie/lottie.dart';


class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with TickerProviderStateMixin{
  bool isChecked = false;
  late AnimationController animationController;
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    return PopScope(
      // onWillPop: () async => false,
      canPop: false,
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          return Scaffold(
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
                      const Text('Task List Screen', style: TextStyle(color:kWhiteColor, fontSize: 30.0, fontWeight: FontWeight.w700),),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('taskData').where("user", isEqualTo: currentUser.toString()).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                          if (snapshot.hasData) {
                            final docs = snapshot.data!.docs;
                            return docs.isEmpty ? Text('0 Tasks', style: TextStyle(color:kWhiteColor, fontSize: 18),) :
                            (docs.length>=2 ? Text('${docs.length.toString()} Tasks', style: TextStyle(color:kWhiteColor, fontSize: 18),) : Text('1 Task', style: TextStyle(color:kWhiteColor, fontSize: 18),));
                          }

                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kThemeBlueColor,
                                strokeWidth: 4.0,
                                color: Colors.white,
                                valueColor: animationController.drive(ColorTween(begin: Colors.blueAccent, end: kThemeBlueColor)),
                              ),
                            ),
                          );
                        },
                      )
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
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance.collection('taskData').where("user", isEqualTo: currentUser.toString()).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;
                          return docs.isNotEmpty ?
                          Container(
                            padding: const EdgeInsets.only(top: 10.0),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                isChecked = data['isTaskComplete'];

                                if(data['user'].toString() == currentUser.toString()){

                                  return Column(
                                    children: [
                                      const SizedBox(height: 10,),
                                      ListTile(
                                        title: SizedBox(
                                            width: MediaQuery.of(context).size.width-100,
                                            child:Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20.0,
                                                      child: Text(
                                                        '${(i+1).toString()}.',
                                                        style: TextStyle(decoration: isChecked == true? TextDecoration.lineThrough : null, color: kThemeBlueColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 2.0,
                                                    ),
                                                    Text(
                                                      data['task'],
                                                      style: TextStyle(decoration: isChecked == true? TextDecoration.lineThrough : null, color: kThemeBlueColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 22.0,
                                                    ),
                                                    SizedBox(
                                                      width:200.0,
                                                      child: Text(
                                                        data['description'],
                                                        style: TextStyle(decoration: isChecked == true? TextDecoration.lineThrough : null, color: kThemeBlueColor, fontSize: 18.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                        ),
                                        trailing: SizedBox(
                                          width: 72,
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: isChecked,
                                                activeColor: kThemeBlueColor,
                                                onChanged: (bool? value){
                                                  setState(() {
                                                    isChecked = value!;
                                                    FirebaseFirestore.instance.collection('taskData').doc(docs[i].id).update({'isTaskComplete': isChecked});
                                                  });
                                                },
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  _showMyDialog('Do you want to delete this task?', docs[i].id);
                                                },
                                                child: const Icon(Icons.delete),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                              },
                            ),
                          )  :
                          Center(
                            // child:Container(
                            //   height: MediaQuery.of(context).size.height-300,
                            //   width: MediaQuery.of(context).size.width,
                            //   child: Text('You Have No Tasks'),
                            //   child: EmptyWidget(
                            //     image: "assets/images/im_emptyIcon_1.png",
                            //     packageImage: PackageImage.Image_1,
                            //     title: 'You Have No Tasks',
                            //     titleTextStyle: const TextStyle(
                            //       fontSize: 22,
                            //       color: kThemeBlueColor,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //     subtitleTextStyle: const TextStyle(
                            //       fontSize: 14,
                            //       color: Color(0xffabb8d6),
                            //     ),
                            //     // Uncomment below statement to hide background animation
                            //     // hideBackgroundAnimation: true,
                            //   ),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('images/lottieAnimation.json', width: 200, height: 200),
                                // const SizedBox(height: 16),
                                // const Text(
                                //   'No Tasks',
                                //   style: TextStyle(fontSize: 18, color: Colors.grey),
                                // ),
                              ],
                            ),
                          );
                        }

                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: kThemeBlueColor,
                              strokeWidth: 4.0,
                              color: Colors.white,
                              valueColor: animationController.drive(ColorTween(begin: Colors.blueAccent, end: kThemeBlueColor)),
                              //backgroundColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    )
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Future _showMyDialog(String text, String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text, style: const TextStyle(color: kThemeBlueColor, fontSize: 20.0)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes',style: TextStyle(color: kThemeBlueColor,fontSize: 18.0),),
              onPressed: () async{
                FirebaseFirestore.instance.collection('taskData').doc(docID).delete();
                Navigator.of(context).pop();
                deleteConfirmationDialog();
              },
            ),
            TextButton(
              child: const Text('No', style: TextStyle(color: kThemeBlueColor,fontSize: 18.0),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future deleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success!', style: TextStyle(color: kThemeBlueColor)),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Task deleted successfully!', style: TextStyle(color: kThemeBlueColor)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: kThemeBlueColor),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

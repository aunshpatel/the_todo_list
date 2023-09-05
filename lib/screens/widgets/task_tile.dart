import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts.dart';
import 'package:empty_widget/empty_widget.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> with TickerProviderStateMixin{

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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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

                  return Container(
                    child: ListTile(
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
                                SizedBox(
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
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          )  :
          Center(
            child:Container(
              height: MediaQuery.of(context).size.height-300,
              width: MediaQuery.of(context).size.width,
              child: EmptyWidget(
                image: "assets/images/im_emptyIcon_1.png",
                packageImage: PackageImage.Image_1,
                title: 'You Have No Tasks',
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: kThemeBlueColor,
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
                // Uncomment below statement to hide background animation
                // hideBackgroundAnimation: true,
              ),
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
                Text(text, style: TextStyle(color: kThemeBlueColor)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes',style: TextStyle(color: kThemeBlueColor),),
              onPressed: () async{
                FirebaseFirestore.instance.collection('taskData').doc(docID).delete();
                Navigator.of(context).pop();
                deleteConfirmationDialog();
              },
            ),
            TextButton(
              child: const Text('No', style: TextStyle(color: kThemeBlueColor),),
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
          content: SingleChildScrollView(
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
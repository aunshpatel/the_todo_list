import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../consts.dart';
import 'package:empty_widget/empty_widget.dart';
//final _firestore = FirebaseFirestore.instance;

class TaskTile extends StatefulWidget {
  const TaskTile({super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> with TickerProviderStateMixin{

  bool isChecked = false;
  //String currentUser = 'patelaunsh28@gmail.com';
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
    /*return ListTile(
      title: Text(
        'This is a task',
        style: TextStyle(decoration: isChecked == true? TextDecoration.lineThrough : null),
      ),
      trailing:Checkbox(
        value: isChecked,
        activeColor: kLightThemeColor,
        onChanged: (bool? value){
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );*/
    
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
                    /*decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: darkTheme == false ? kWhiteColor : kBlackColor,
                        ),
                      ),
                    ),*/
                    //padding: const EdgeInsets.only(top: 5.0),
                    child: ListTile(
                      /*onLongPress: () async{
                        _showMyDialog('Do you want to delete this task?', docs[i].id);
                      },*/
                      title: SizedBox(
                        width: MediaQuery.of(context).size.width-100,
                        child: Text(
                          data['task'],
                          style: TextStyle(decoration: isChecked == true? TextDecoration.lineThrough : null, color: kThemeBlueColor),
                          //style: kTextStyle,
                        ),
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


                // isTaskAvailable == false ? Center(
                //   child:Container(
                //     height: MediaQuery.of(context).size.height-300,
                //     width: MediaQuery.of(context).size.width,
                //     //alignment: Alignment.center,
                //     child: EmptyWidget(
                //       // Image from project assets
                //       image: "assets/images/im_emptyIcon_1.png",
                //       packageImage: PackageImage.Image_1,
                //       title: 'You Have No Tasks',
                //       //subTitle: 'No  notification available yet',
                //       titleTextStyle: TextStyle(
                //         fontSize: 22,
                //         color: kThemeBlueColor,
                //         //color: Color(0xff9da9c7),
                //         fontWeight: FontWeight.w500,
                //       ),
                //       subtitleTextStyle: TextStyle(
                //         fontSize: 14,
                //         color: Color(0xffabb8d6),
                //       ),
                //       // Uncomment below statement to hide background animation
                //       // hideBackgroundAnimation: true,
                //     ),
                //   ),
                // ) : Container();

                // else{
                //   return Container();
                // }
                /*else{
                  return Center(
                    child:Container(
                      height: MediaQuery.of(context).size.height-300,
                      width: MediaQuery.of(context).size.width,
                      //alignment: Alignment.center,
                      child: EmptyWidget(
                        // Image from project assets
                        image: "assets/images/im_emptyIcon_1.png",
                        packageImage: PackageImage.Image_1,
                        title: 'You Have No Tasks',
                        //subTitle: 'No  notification available yet',
                        titleTextStyle: TextStyle(
                          fontSize: 22,
                          color: kThemeBlueColor,
                          //color: Color(0xff9da9c7),
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
                }*/

              },
            ),
          )  :
          Center(
            child:Container(
              height: MediaQuery.of(context).size.height-300,
              width: MediaQuery.of(context).size.width,
              //alignment: Alignment.center,
              child: EmptyWidget(
                // Image from project assets
                image: "assets/images/im_emptyIcon_1.png",
                packageImage: PackageImage.Image_1,
                title: 'You Have No Tasks',
                //subTitle: 'No  notification available yet',
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: kThemeBlueColor,
                  //color: Color(0xff9da9c7),
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
      },
    );
  }

  Future _showMyDialog(String text, String docID) async {
    //String AlertText = text;
    //String documentID = docID;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('Warning!'),
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
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_todo_list/consts.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   late Material materialButton;
//   late int index;
//   final onboardingPagesList = [
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: kWhiteColor,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0),
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: Text(
//                     'Welcome to',
//                     style: onboardScreenHeaderStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               //const SizedBox(height: 10,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 45.0),
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: SizedBox(
//                     //padding: EdgeInsets.all(10.0),
//                     height: 400.0,
//                     child: Image.asset('images/todo-list-blue-transparent-bg.png',),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: kWhiteColor,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 //padding: EdgeInsets.all(10.0),
//                 height: 350.0,
//                 child: Image.asset('images/add-new-task.jpeg',),
//               ),
//               const SizedBox(height: 10,),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 45.0),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     'Add tasks from the plus button',
//                     style: onboardScreenTextStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: kWhiteColor,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//
//         child: Container(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 //padding: EdgeInsets.all(10.0),
//                 height: 350.0,
//                 child: Image.asset('images/task-done.jpeg',),
//               ),
//               const SizedBox(height: 10,),
//               Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Once your task is complete, press on the checkbox to update its status.',
//                   style: onboardScreenTextStyle,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     PageModel(
//       widget: DecoratedBox(
//         decoration: BoxDecoration(
//           color: kWhiteColor,
//           border: Border.all(
//             width: 0.0,
//             color: background,
//           ),
//         ),
//         child:  Container(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SizedBox(
//                 //padding: EdgeInsets.all(10.0),
//                 height: 350.0,
//                 child: Image.asset('images/delete-task.jpeg',),
//               ),
//               SizedBox(height: 10,),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50.0),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Text(
//                     'To delete task, you can press the delete button',
//                     style: onboardScreenTextStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     materialButton = _skipButton();
//     index = 0;
//   }
//
//   Material _skipButton({void Function(int)? setIndex}) {
//     return Material(
//       borderRadius: defaultSkipButtonBorderRadius,
//       color: kThemeBlueColor,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: kWhiteColor)
//         ),
//         child: InkWell(
//           borderRadius: defaultSkipButtonBorderRadius,
//           onTap: () {
//             if (setIndex != null) {
//               index = 3;
//               setIndex(3);
//             }
//           },
//           child: const Padding(
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'Skip',
//               style: defaultSkipButtonTextStyle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Material get goToLoginButton {
//     return Material(
//       borderRadius: defaultProceedButtonBorderRadius,
//       color: kThemeBlueColor,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: kWhiteColor)
//         ),
//         child: InkWell(
//           borderRadius: defaultProceedButtonBorderRadius,
//           onTap: () {
//             Navigator.pushNamed(context, '/login_screen');
//           },
//           child: const Padding(
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'Go to login',
//               style: defaultProceedButtonTextStyle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Material get returnToTaskScreen {
//     return Material(
//       borderRadius: defaultProceedButtonBorderRadius,
//       color: kThemeBlueColor,
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: kWhiteColor)
//         ),
//         child: InkWell(
//           borderRadius: defaultProceedButtonBorderRadius,
//           onTap: () {
//             Navigator.pushNamed(context, '/task_screen');
//           },
//           child: const Padding(
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'Go back',
//               style: defaultProceedButtonTextStyle,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//         child: Scaffold(
//           body: Onboarding(
//             pages: onboardingPagesList,
//             onPageChange: (int pageIndex) {
//               index = pageIndex;
//             },
//             startPageIndex: 0,
//             footerBuilder: (context, dragDistance, pagesLength, setIndex) {
//               return (howTo == false ? DecoratedBox(
//                 decoration: const BoxDecoration(
//                   color: kWhiteColor,
//                 ),
//                 child: ColoredBox(
//                   color: kWhiteColor,
//                   child: Container(
//                     color: kThemeBlueColor,
//                     padding: const EdgeInsets.all(45.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomIndicator(
//                           netDragPercent: dragDistance,
//                           pagesLength: pagesLength,
//                           indicator: Indicator(
//                             indicatorDesign: IndicatorDesign.polygon(
//                               polygonDesign: PolygonDesign(
//                                 polygon: DesignType.polygon_circle
//                               )
//                             )
//                           ),
//                         ),
//                         index == pagesLength - 1 ? goToLoginButton : _skipButton(setIndex: setIndex)
//                       ],
//                     ),
//                   ),
//                 ),
//               ) : DecoratedBox(
//                 decoration: const BoxDecoration(
//                   color: kWhiteColor,
//                 ),
//                 child: ColoredBox(
//                   color: kWhiteColor,
//                   child: Container(
//                     color: kThemeBlueColor,
//                     padding: const EdgeInsets.all(45.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomIndicator(
//                           netDragPercent: dragDistance,
//                           pagesLength: pagesLength,
//                           indicator: Indicator(
//                             indicatorDesign: IndicatorDesign.polygon(
//                               polygonDesign: PolygonDesign(
//                                   polygon: DesignType.polygon_circle
//                               )
//                             )
//                           ),
//                         ),
//                         returnToTaskScreen
//                       ],
//                     ),
//                   ),
//                 ),
//               ));
//             },
//           ),
//         ),
//       )
//     );
//   }
// }

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final pages = [
      PageModel(
        color: const Color(0xFF0097A7),
        imageAssetPath: 'images/todo-list-blue-transparent-bg.png',
        title: 'Welcome to The Todo List',
        body: '',
        doAnimateImage: true
      ),
      PageModel(
        color: const Color(0xFF536DFE),
        imageAssetPath: 'images/add-new-task.jpg',
        title: 'Add tasks from the plus(+) button.',
        body: '',
        doAnimateImage: true
      ),
      PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'images/task-done.jpg',
        title: 'Once your task is complete, press on the checkbox to update its status.',
        body: '',
        doAnimateImage: true
      ),
      PageModel(
        color: const Color(0xFF5886d6),
        imageAssetPath: 'images/delete-task.jpg',
        title: 'To delete task, press the delete button and confirm.',
        body: '',
        doAnimateImage: true
      ),
    ];
    return Scaffold(
      key: _globalKey,
      body: isLoggedIn == false ? OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          Navigator.pushNamed(context, '/login_screen');
          // Navigator.pushNamed(context, '/task_screen');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You have skipped the onboarding steps. They can be visited again from menu later on."),
          ));
        },
        finishText: 'GO TO LOGIN',
            //: 'GO TO TASK SCREEN',
        finishCallback: () {
          Navigator.pushNamed(context, '/login_screen');
        },
      ) : OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          Navigator.pushNamed(context, '/task_screen');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You have skipped the onboarding steps. They can be visited again from menu later on."),
          ));
        },
        finishText: 'GO TO Task Screen',
        //: 'GO TO TASK SCREEN',
        finishCallback: () {
          Navigator.pushNamed(context, '/task_screen');
        },
      )
    );
  }
}
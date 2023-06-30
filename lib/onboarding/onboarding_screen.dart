import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_todo_list/consts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Welcome to',
                    style: onboardScreenHeaderStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              //const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    //padding: EdgeInsets.all(10.0),
                    height: 400.0,
                    child: Image.asset('images/todo-list-blue-transparent-bg.png',),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                //padding: EdgeInsets.all(10.0),
                height: 350.0,
                child: Image.asset('images/add-new-task.jpeg',),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Add tasks from the plus button',
                    style: onboardScreenTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),

        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                //padding: EdgeInsets.all(10.0),
                height: 350.0,
                child: Image.asset('images/task-done.jpeg',),
              ),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Once your task is complete, press on the checkbox to update its status.',
                  style: onboardScreenTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child:  Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                //padding: EdgeInsets.all(10.0),
                height: 350.0,
                child: Image.asset('images/delete-task.jpeg',),
              ),
              SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'To delete task, you can press the delete button',
                    style: onboardScreenTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: kThemeBlueColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kWhiteColor)
        ),
        child: InkWell(
          borderRadius: defaultSkipButtonBorderRadius,
          onTap: () {
            if (setIndex != null) {
              index = 3;
              setIndex(3);
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Skip',
              style: defaultSkipButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  Material get goToLoginButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: kThemeBlueColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kWhiteColor)
        ),
        child: InkWell(
          borderRadius: defaultProceedButtonBorderRadius,
          onTap: () {
            Navigator.pushNamed(context, '/login_screen');
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Go to login',
              style: defaultProceedButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  Material get returnToTaskScreen {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: kThemeBlueColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kWhiteColor)
        ),
        child: InkWell(
          borderRadius: defaultProceedButtonBorderRadius,
          onTap: () {
            Navigator.pushNamed(context, '/task_screen');
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Go back',
              style: defaultProceedButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: SafeArea(
        child: Scaffold(
          body: Onboarding(
            pages: onboardingPagesList,
            onPageChange: (int pageIndex) {
              index = pageIndex;
            },
            startPageIndex: 0,
            footerBuilder: (context, dragDistance, pagesLength, setIndex) {
              return (howTo == false ? DecoratedBox(
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                ),
                child: ColoredBox(
                  color: kWhiteColor,
                  child: Container(
                    color: kThemeBlueColor,
                    padding: const EdgeInsets.all(45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIndicator(
                          netDragPercent: dragDistance,
                          pagesLength: pagesLength,
                          indicator: Indicator(
                            indicatorDesign: IndicatorDesign.line(
                              lineDesign: LineDesign(
                                lineType: DesignType.line_uniform,
                              ),
                            ),
                          ),
                        ),
                        index == pagesLength - 1 ? goToLoginButton : _skipButton(setIndex: setIndex)
                      ],
                    ),
                  ),
                ),
              ) :DecoratedBox(
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                ),
                child: ColoredBox(
                  color: kWhiteColor,
                  child: Container(
                    color: kThemeBlueColor,
                    padding: const EdgeInsets.all(45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIndicator(
                          netDragPercent: dragDistance,
                          pagesLength: pagesLength,
                          indicator: Indicator(
                            indicatorDesign: IndicatorDesign.line(
                              lineDesign: LineDesign(
                                lineType: DesignType.line_uniform,
                              ),
                            ),
                          ),
                        ),
                        returnToTaskScreen
                      ],
                    ),
                  ),
                ),
              )
              //     Container(
              //   child: Center(
              //     child: ,
              //   ),
              // )
              );
            },
          ),
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double? _deviceHight, _deviceWidth;
  double sliderVal = 0;
  List<String> difficultyLevel = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [titleWidget(), difficultyWidget()]),
            sliderWidget(),
            startButton()
          ],
        ),
      )),
    );
  }

  Widget titleWidget() {
    return const Text("Frivia",
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w400));
  }

  Widget difficultyWidget() {
    return Text(difficultyLevel[sliderVal.toInt()],
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 25,
        ));
  }

  Widget sliderWidget() {
    return SizedBox(
      width: _deviceWidth! * 0.8,
      child: Slider(
        max: 2,
        min: 0,
        value: sliderVal,
        onChanged: (value) {
          setState(() {
            sliderVal = value;
          });
        },
        divisions: 2,
        label: 'Difficulty',
        activeColor: Colors.blue,
        inactiveColor: Colors.blue[100],
      ),
    );
  }

  Widget startButton() {
    return MaterialButton(
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHight! * 0.1,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (builder) {
          return GamePage(
              difficultyLevel:
                  difficultyLevel[sliderVal.toInt()].toLowerCase());
        }));
      },
      color: Colors.blue,
      child: const Text(
        "Start",
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}

// ignore_for_file: unused_field, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:friviaa/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  double? _deviceHight, _deviceWidth;
  final String difficultyLevel;
  GamePageProvider? pageProvider;
  GamePage({required this.difficultyLevel});
  @override
  Widget build(BuildContext context) {
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) =>
          GamePageProvider(context: context, difficultyLevel: difficultyLevel),
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(builder: (context) {
      pageProvider = context.watch<GamePageProvider>();
      if (pageProvider!.questions != null) {
        return Scaffold(
            body: SafeArea(
                child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceHight! * 0.05),
          child: gameUI(),
        )));
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }
    });
  }

  Widget gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(
              height: _deviceHight! * 0.01,
            ),
            falseButton()
          ],
        )
      ],
    );
  }

  Widget questionText() {
    return Text(
      pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion('False');
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHight! * 0.10,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}

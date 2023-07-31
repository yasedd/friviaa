import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int _maxQuestions = 10;
  String? difficultyLevel;
  List? questions;
  int _currentQuestion = 0;
  int _score = 0;

  BuildContext context;
  GamePageProvider({required this.context, this.difficultyLevel}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQestionsFromAPI();
  }
  Future<void> _getQestionsFromAPI() async {
    var _responce = await dio.get('', queryParameters: {
      'amount': 10,
      'type': 'boolean',
      'difficulty': difficultyLevel,
    });
    var _data = jsonDecode(_responce.toString());
    questions = _data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    print(questions![_currentQuestion]["question"]);
    return questions![_currentQuestion]["question"];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect = questions![_currentQuestion]['correct_answer'] == _answer;
    _currentQuestion++;
    if (isCorrect) {
      _score++;
    }
    // print(isCorrect ? "Correct!" : "InCorrect");
    showDialog(
        context: context,
        builder: (_context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (_currentQuestion == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "End Game!",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            content: Text("Score : $_score/$_maxQuestions"),
          );
        });
    await Future.delayed(const Duration(seconds: 3));
    //exit dialog
    Navigator.pop(context);
    //exit gamepage
    Navigator.pop(context);
    // _currentQuestion = 0;
  }
}

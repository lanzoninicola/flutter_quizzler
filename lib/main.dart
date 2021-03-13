import 'package:flutter/material.dart';
import 'package:flutter_quizzler/models/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  List<Widget> answerKeeper = [];

  void trackCorrectAnswer() {
    List<Widget> nextAnswerKeeper = [...answerKeeper];
    nextAnswerKeeper.add(Icon(
      Icons.check,
      color: Colors.green,
    ));

    setState(() {
      answerKeeper = [...nextAnswerKeeper];

      if (quizBrain.isQuizCompleted()) {
        showDialogQuizCompleted(context);
        answerKeeper = [];  
      }
    });
  }

  void trackIncorrectAnswer() {
    List<Widget> nextAnswerKeeper = [...answerKeeper];
    nextAnswerKeeper.add(Icon(
      Icons.clear,
      color: Colors.red,
    ));

    setState(() {
      answerKeeper = [...nextAnswerKeeper];
      if (quizBrain.isQuizCompleted()) {
        showDialogQuizCompleted(context);
        answerKeeper = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Quizzler App"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  '${quizBrain.getQuestionText()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[400])),
                    onPressed: () {
                      bool answer = quizBrain.getQuestionAnswer();

                      if (answer == true) {
                        trackCorrectAnswer();
                      } else {
                        trackIncorrectAnswer();
                      }

                      quizBrain.getNextQuestion();
                    },
                    child: Text(
                      "TRUE",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[400])),
                    onPressed: () {
                      bool answer = quizBrain.getQuestionAnswer();

                      if (answer == false) {
                        trackCorrectAnswer();
                      } else {
                        trackIncorrectAnswer();
                      }

                      quizBrain.getNextQuestion();
                    },
                    child: Text("FALSE",
                        style: TextStyle(
                          fontSize: 24,
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
              child: Row(
                children: [...answerKeeper],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScoreKeeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void showDialogQuizCompleted(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.info,
    title: "GOOD JOB!!!",
    desc: "You have finished the quiz",
    buttons: [
      DialogButton(
        child: Text(
          "RESTART",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => quizBrain.restartQuiz(),
        width: 120,
      )
    ],
  ).show();
}

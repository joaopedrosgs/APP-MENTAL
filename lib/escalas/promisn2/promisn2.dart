import 'package:app_mental/Screens/Contacts/contacts_screen.dart';
import 'package:app_mental/Services/database.dart';
import 'package:app_mental/main.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:app_mental/escalas/promis_answer.dart';

class Promisn2 extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final List<int> resultScoreList;
  final Function answerQuestion;
  final Function resetQuestion;
  final String userEmail;
  final String userEscala;
  final String questName;
  final DatabaseMethods databaseMethods = new DatabaseMethods();
  final DateTime now = DateTime.now();

  Promisn2({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
    required this.resultScoreList,
    required this.userEmail,
    required this.userEscala,
    required this.questName,
    required this.resetQuestion,
  });

  sendPromisn2PartialScore(String email) {
    Map<String, dynamic> answerMap = {
      "q1": resultScoreList[1],
      "q2": resultScoreList[2],
      "q3": resultScoreList[3],
      "q4": resultScoreList[4],
      "q5": resultScoreList[5],
      "q6": resultScoreList[6],
      "q7": resultScoreList[7],
      "q8": resultScoreList[8],
      "answeredAt": now,
      "questName": questName,
      "answeredUntil": questionIndex,
    };
    databaseMethods.addQuestAnswer(answerMap, userEmail, userEscala);
    databaseMethods.updateQuestIndex(userEscala, userEmail, questionIndex);
  }

  isCritical() {
    int sum =
        resultScoreList.fold(0, (previous, current) => previous + current);
    if (sum > 16) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var lastIndex = questions.length + 1;
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(top: 6, left: 2, right: 2, bottom: 2),
      padding: EdgeInsets.only(top: 6, left: 2, right: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Questão ${questionIndex + 1} de $lastIndex",
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return PromisAnswer(
              () => answerQuestion(answer['score']),
              answer['text']!,
            );
          }).toList(),
          Spacer(),
          Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    resetQuestion();
                  },
                  child: const Text("Voltar para a questão anterior"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(104, 202, 138, 1)),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Responder depois'),
                      content: const Text(
                          'Deseja salvar suas respostas e terminar de responder mais tarde?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            sendPromisn2PartialScore(userEmail);
                            if (isCritical()) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                      'Entre em contato com alguém!'),
                                  content: const Text(
                                      'Percebemos que você pode estar em um estado bastante delicado e gostaríamos de sugerir que entre em contato conosco ou com alguém próximo!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context, 'Ok');
                                        await Navigator.of(context).pushNamed(
                                          ContactsScreen.routeName,
                                          arguments: {},
                                        );
                                      },
                                      child: const Text('Ok',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  104, 202, 138, 1))),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.pop(context, 'Ok');
                              await Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            }
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Responder depois',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//import 'fancy_button.dart'
import 'package:chat_app_tutorial/escalas/promisn1/promisn1.dart';
import 'package:chat_app_tutorial/escalas/promisn1/promisn1_result.dart';
import 'package:flutter/material.dart';

class Promisn1Screen extends StatefulWidget {
  static const routeName = '/promisn1-screen';

  @override
  _Promisn1ScreenState createState() {
    return _Promisn1ScreenState();
  }
}

class _Promisn1ScreenState extends State<Promisn1Screen> {
  static const _questions = [
    {
      'questionText':
          'As questões a seguir perguntam sobre coisas que podem tê-lo pertubado. Para cada pergunta, escolha o número que melhor descreve o quanto (ou com que frequência) você foi perturbado pelos problemas descritos a seguir.',
      'answers': [
        {'text': 'Entendi e quero prosseguir', 'score': 0, 'dom': 0},
      ],
    },
    {
      'questionText': 'I. 1. Pouco Interesse ou prazer em fazer as coisas?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 1},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 1
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 1},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 1},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 1},
      ],
    },
    {
      'questionText': 'I. 2. Sentiu-se desanimado, deprimido ou sem esperança?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 1},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 1
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 1},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 1},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 1},
      ],
    },
    {
      'questionText':
          ' II. 3. Sentiu-se mais irritado, mal humorado ou zangado do que o usual?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 2},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 2
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 2},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 2},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 2},
      ],
    },
    {
      'questionText':
          'III. 4. Dormiu menos que o usual mas ainda tem muita energia?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 3},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 3
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 3},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 3},
      ],
    },
    {
      'questionText':
          'III. 5. Iniciou muito mais projetos do que o usual ou fez coisas mais arriscadas do que o habitual?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 3},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 3
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 3},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 3},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 3},
      ],
    },
    {
      'questionText':
          'IV. 6. Sentiu-se nervoso, ansioso, assustado, preocupado ou tenso?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 4},
      ],
    },
    {
      'questionText': 'IV. 7. Sentiu pânico ou se sentiu amedrontado?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 4},
      ],
    },
    {
      'questionText': 'IV. 8. Evitou situações que o deixam ansioso?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 4},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 4
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 4},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 4},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 4},
      ],
    },
    {
      'questionText':
          'V. 9. Dores e sentimentos sem explicação? (p. ex. cabeça, costas, articulações, abdome, pernas)?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 5},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 5
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 5},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 5},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 5},
      ],
    },
    {
      'questionText':
          'V. 10. Sentimento de que suas doenças não estão sendo levadas suficientemente a sério?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 5},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 5
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 5},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 5},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 5},
      ],
    },
    {
      'questionText': 'VI. 11. Pensamento de ferir a si mesmo?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 6},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 6
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 6},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 6},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 6},
      ],
    },
    {
      'questionText':
          'VII. 12. Ouviu coisas que outras pessoas não ouviam, como vozes, mesmo quando não havia ninguém por perto?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 7},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 7
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 7},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 7},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 7},
      ],
    },
    {
      'questionText':
          'VII. 13. Sentiu que alguém podia ouvir seus pensamentos ou que você podia ouvir o que outra pessoa estava pensando?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 7},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 7
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 7},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 7},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 7},
      ],
    },
    {
      'questionText':
          'VIII. 14. Problemas com sono que afetaram a qualidade do seu sono em geral?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 8},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 8
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 8},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 8},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 8},
      ],
    },
    {
      'questionText':
          'IX. 15. Problemas com memória (p. ex. aprender informações novas) ou com localização (p. ex. encontrar o caminho para casa)?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 9},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 9
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 9},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 9},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 9},
      ],
    },
    {
      'questionText':
          'X. 16. Pensamentos impulsos ou imagens desagradáveis que entram repetidamente na sua cabeça?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 10},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 10
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 10},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 10},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 10},
      ],
    },
    {
      'questionText':
          'X. 17. Sentiu-se compelido a realizar certos comportamentos ou atos mentais repetidamente?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 10},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 10
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 10},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 10},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 10},
      ],
    },
    {
      'questionText':
          'XI. 18. Sentiu-se desligado ou distante de si mesmo, do seu corpo, do ambiente físico ao seu redor ou de suas lembranças?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 11},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 11
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 11},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 11},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 11},
      ],
    },
    {
      'questionText':
          'XII. 19. Sem saber quem você realmente é ou o que você quer da vida?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 12},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 12
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 12},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 12},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 12},
      ],
    },
    {
      'questionText':
          'XII. 20. Não se sentiu próximo a outras pessoas ou desfrutou de suas relações com elas?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 12},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 12
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 12},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 12},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 12},
      ],
    },
    {
      'questionText':
          'XIII. 21. Bebeu no mínimo 4 drinques de qualquer tipo de bebida alcoólica em um único dia?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 13},
      ],
    },
    {
      'questionText':
          'XIII. 22. Fumou cigarros, charutos ou cachimbo ou usou rapé ou tabaco de mascar?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 13},
      ],
    },
    {
      'questionText':
          'XIII. 23. Usou algum dos seguintes medicamento POR CONTA PRÓPRIA, isto é, sem prescrição médica, em quantidades maiores ou por mais tempo do que prescrito?',
      'answers': [
        {'text': 'Nada. De modo algum', 'score': 0, 'dom': 13},
        {
          'text': 'Muito leve. Raramente, menos de um ou dois dias',
          'score': 1,
          'dom': 13
        },
        {'text': 'Leve. Vários dias', 'score': 2, 'dom': 13},
        {'text': 'Moderado. Mais da metade dos dias', 'score': 3, 'dom': 13},
        {'text': 'Grave. Quase todos os dias', 'score': 4, 'dom': 13},
      ],
    },
  ];

  //(p. ex. analgésicos, estimulantes, sedativos ou tranquilizantes, ou drogas como maconha, cocaína ou crack, drogas sintéticas, alucinógenos, heroína, inalantes ou solventes ou metanfetamina?
  var _questionIndex = 0;
  var _totalScoreList = List<int>.filled(14, 0);

  /*void _resetQuiz(BuildContext ctx) {
    _questionIndex = 0;
    _totalScore = 0;
    Navigator.of(ctx).pop();
    /*setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    }); */
*/
  void _answerQuestion(int score, int domin) {
    _totalScoreList[domin] += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questions.length) {
      print('ahn');
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final titleAA = routeArgs['title'];
    final _userEscala = routeArgs['userEscala'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titleAA),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: _questionIndex < _questions.length
            ? Promisn1(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              ) //Quiz
            : Promisn1Result(
                resultScoreList: _totalScoreList,
                questName: titleAA,
                userEscala: _userEscala,
              ),
      ), //Padding
    ); //Scaffold
    // debugShowCheckedModeBanner: false,;
  }
}

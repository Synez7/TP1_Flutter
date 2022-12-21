import 'package:flutter/material.dart';
import 'package:profilecard/Question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'main.dart';


class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<QuizzPage> createState() => SomeQuizzPageState();
}

class SomeQuizzPageState extends State<QuizzPage> {



  final List<Widget> scoreKeeper = []; // Liste de symboles (check vert ou une croix rouge) indiquant si la réponse choisie par l'utilisateur est vraie ou fausse

  final List<Question> questions = [
    Question(questionText: "C'est un Français qui a eu l'idée de créer la Coupe du monde.", isCorrect: true),
    Question(questionText: "Kylian Mbappé est le plus jeune joueur à marquer trois buts en Coupe du monde.", isCorrect: false),
    Question(questionText: "La première édition de la Coupe du monde a eu lieu au Brésil.", isCorrect: false),
    Question(questionText: "L' Allemagne détient le plus grand nombre de participations en Coupe du monde.", isCorrect: false),
    Question(questionText: "Ils étaient 1,12 milliard de téléspectateurs à suivre la finale de la Coupe du monde 2018.", isCorrect: true),
    Question(questionText: "Les Pays-Bas comptent le plus grand nombre de finales perdues.", isCorrect: true),
    Question(questionText: "Le record de buts inscrits en une édition appartient au Brésil.", isCorrect: false),
    Question(questionText: "Le Cameroun est le premier pays africain à atteindre les quarts de finale.", isCorrect: true),
    Question(questionText: "La Corée du Sud a déjà atteint les demi-finales d'un Mondial.", isCorrect: true),
    Question(questionText: "Just Fontaine a inscrit le plus grand nombre de buts en Coupe du monde.", isCorrect: true),
  ]; // Liste des questions de quizz

  int countClick = 0; // compteur de clic pour s'assurer de ne pas pouvoir répondre plus d'une fois à une même question

  int _questionNumber = 0; // initialisation du numéro de question

  int totalRightAnswers = 0; // nombre de réponses correctes pour l'utilisateur

  int numberQuestions = 10; // nombre de questions du quizz

  bool isFinished = false;  // indication pour savoir si le quizz est fini ou non




  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        if (_questionNumber >= 1) {
          Alert(
              context: context,
              title: "Retour arrière",
              desc: "Veuillez terminer ce quizz pour ensuite revenir en arrière",
              buttons: [
                DialogButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK",
                        style: TextStyle(color: Colors.white, fontSize: 16)))
              ]).show();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 70, top: 6, left: 50, right: 50),
                    child: Image.asset("images/worldcup.jpg", width: 300,
                      height: 200,
                      fit: BoxFit.cover,),
                  ),
                  Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.white24,
                        )),
                    child: Center(
                      child: Text(questions[_questionNumber].questionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Container(
                      padding: EdgeInsets.only(top: 80),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(20),
                                child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(Colors.blueGrey),),
                                      onPressed: () {
                                        countClick++;
                                        if (countClick == 1) {
                                          setState(() {
                                            _checkAnswer(true, context);
                                          });
                                        }
                                      },
                                      child: const Text("VRAI", style: TextStyle(
                                          color: Colors.white),),
                                    ))),

                            Padding(
                                padding: EdgeInsets.all(20),
                                child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(Colors.blueGrey),),
                                      onPressed: () {
                                        countClick++;
                                        if (countClick == 1) {
                                          setState(() {
                                            _checkAnswer(false, context);
                                          });
                                        }
                                      },
                                      child: const Text("FAUX", style: TextStyle(
                                          color: Colors.white),),
                                    )
                                )),

                            Padding(
                                padding: EdgeInsets.all(20),
                                child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all(Colors.blueGrey),),
                                      onPressed: () {
                                        if (countClick > 0 && _questionNumber <
                                            questions.length) {
                                          countClick = 0;
                                          setState(() {
                                              _nextQuestion();
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.arrow_forward),
                                    )
                                )),
                          ]

                      )),

                  Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: scoreKeeper,))

                ])),

        backgroundColor: Colors.blueGrey,
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Question _nextQuestion() {

    // condition marquant la fin du quizz
    if (_questionNumber == questions.length-1) {
      isFinished = true;

        // Fenêtre de dialogue affichant le score de l'utilisateur pour ce quizz et la possibilité d'y rejouer ou de revenir vers la carte de profil
        Alert(
            context: context,
            title: "Fin du quizz",
            desc: "Votre score est : $totalRightAnswers/$numberQuestions !",
            buttons: [
              DialogButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: const Text("Rejouer",
                      style: TextStyle(color: Colors.white, fontSize: 22))),

              DialogButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileHomePage()));
                  },
                  child: const Text("Retour",
                      style: TextStyle(color: Colors.white, fontSize: 22)))]).show();

      // Réinitialisation du quizz
      isFinished = false;
      _questionNumber = 0;
      scoreKeeper.clear();
      countClick = 0;
      totalRightAnswers = 0;

      return questions[_questionNumber];

    }
    return questions[_questionNumber++];
  }


    // Méthode de vérification d'une réponse à une question
  bool _checkAnswer(bool userChoice, BuildContext context) {


    // Cas d'une réponse correcte choisie par l'utilisateur
    if (questions[_questionNumber].isCorrect == userChoice) {
      totalRightAnswers++;
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      return true;
    }
    // Cas contraire
    else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      return false;
    }

  }
}

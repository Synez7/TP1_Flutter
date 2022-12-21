import 'package:flutter/material.dart';
import 'QuizzPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My First Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileHomePage(),
    );
  }
}

class ProfileHomePage extends StatefulWidget {


  @override
  State<ProfileHomePage> createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: new Text("Profile Home Page")),
          body: Container(
            padding: EdgeInsets.only(top: 180,left: 8),

            child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  Padding(
                      padding: EdgeInsets.all(55),
                      child: _getCard()
                  ),
                  _getAvatar(),

                  Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizzPage(title: "Questions/Réponses"))),
                          child: Text("Play Quizz")))
                  ]),
        ),
      );

  }

  // CARTE DE PROFIL
  Container _getCard(){

    return Container(
      width: 300,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 90),
        child: Column(
          children:<Widget>[
            Text("Ali Dabachil",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 15)),
            Text("ali.dabachil@etu.umontpellier.fr",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 15)),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  SizedBox(width: 5), // give it width
                  Text("twitter: @User_Test",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 15))

                ]),
          ],
        ),
      ),);
  }

  // AVATAR UTILISATEUR
  Container _getAvatar(){
    return Container(
      width: 220,
      height: 120,
      margin: const EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(width: 1,color: Colors.pinkAccent),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("images/stade.jpg")),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent,
            blurRadius: 1.0,
            offset: Offset(0.0, 5.0),
          ),

        ],
      ),
    );
  }





}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In App But Better',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign In")),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            FittedBox(
                child: Hero(
                    tag: "Logo",
                    child: Container(
                        child: Image.network(
                            "https://www.collegeboreal.ca/static/assets/img/logo-black.png"),
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 60)))),
            Center(
                child: Text(
              "Bienvenu!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.black),
            )),
            Center(child: Text("S.V.P. Sign in")),
            Text(""),
            Text(""),
            Text(""),
            Center(
                child: SizedBox(
              child: TextField(
                  onSubmitted: (String value) async {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Warning(value);
                    }));
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      fillColor: Colors.white)),
              height: 50,
              width: 200,
            ))
          ],
        ));
  }
}

class Warning extends StatelessWidget {
  var username = "John Doe";

  Warning(name) {
    if (name == "") {
      name = "Anonymous";
    }
    this.username = name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Bonjour, " + this.username)),
        body: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(children: [
              FittedBox(
                  child: Hero(
                      tag: "Logo",
                      child: Container(
                          child: Image.network(
                              "https://www.collegeboreal.ca/static/assets/img/logo-black.png"),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 60)))),
              Text(
                  "Afin d'entré au campus, tu as besoin de compléter une questionnaire."),
              Text(""),
              Text(""),
              RaisedButton(
                  child: Text("Accéder au questionnaire."),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Quiz(this.username);
                    }));
                  })
            ])));
  }
}

class Quiz extends StatelessWidget {
  var username = "John Doe";
  var sentiment = "Aucun";
  var voyage = "Aucun";
  var visite = "Aucun";

  Quiz(name) {
    this.username = name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Questionnaire")),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            alignment: Alignment.topCenter,
            child: Column(children: [
              FittedBox(
                  child: Hero(
                      tag: "Logo",
                      child: Container(
                          child: Image.network(
                              "https://www.collegeboreal.ca/static/assets/img/logo-black.png"),
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 60)))),
              Text("\nComment sens-tu aujourd'hui, " + this.username + "?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () async {
                      this.sentiment = "Bien";
                    },
                    child: Text("Bien."),
                  ),
                  RaisedButton(
                      onPressed: () async {
                        this.sentiment = "Moin Bien";
                      },
                      child: Text("Moin Bien.")),
                  RaisedButton(
                      onPressed: () async {
                        this.sentiment = "Terrible";
                      },
                      child: Text("Terrible."))
                ],
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                          "Avez vous voyagez loins dans les derniers 14 jours?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                              onPressed: () async {
                                this.voyage = "Oui";
                              },
                              child: Text("Oui.")),
                          RaisedButton(
                              onPressed: () async {
                                this.voyage = "Non";
                              },
                              child: Text("Non.")),
                        ],
                      )
                    ],
                  )),
              Container(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                              "Avez vous visitez quelqu'un avec le COVID-19 dans les derniers 14 jours?"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                  onPressed: () async {
                                    this.visite = "Oui";
                                  },
                                  child: Text("Oui.")),
                              RaisedButton(
                                  onPressed: () async {
                                    this.visite = "Non";
                                  },
                                  child: Text("Non.")),
                            ],
                          )
                        ],
                      ))),
              //Fini
              RaisedButton(
                  onPressed: () async {
                    if (this.sentiment == "Aucun") {
                      await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Données manquants!'),
                              content: Text('S.V.P entrée une sentiment.'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    } else if (this.voyage == "Aucun") {
                      await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Données manquants!'),
                              content: Text('S.V.P dit nous si tu a voyagé.'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    } else if (this.visite == "Aucun") {
                      await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Données manquants!'),
                              content: Text(
                                  'S.V.P  dit nous si vous avez visitez quelqu\'un avec le COVID-19.'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    } else {
                      //tous les questions on été répondu.
                      print(this.sentiment + this.voyage + this.visite);
                      if (this.visite == "Oui" ||
                          this.sentiment == "Terrible") {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EndScreen(
                              "En risque",
                              "Merci pour répondre à cette questionnaire. Tu devrait retourné à la maison.",
                              Colors.red);
                        }));
                      } else if (this.sentiment == "Bien" &&
                          this.voyage == "Oui") {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EndScreen(
                              "Probablement en santé",
                              "Merci pour répondre à cette questionnaire. Tu est probablement en santé.",
                              Colors.amber);
                        }));
                      } else if (this.sentiment == "Moin Bien") {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EndScreen(
                              "À toi de décider",
                              "Merci pour répondre à cette questionnaire. Si tu resent des symptomes de COVID-19, S.V.P retourné à la maison.",
                              Colors.amber);
                        }));
                      } else if (this.sentiment == "Bien" &&
                          this.voyage == "Non") {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EndScreen(
                              "En Santé",
                              "Merci pour répondre à cette questionnaire. Tu est très en santé.",
                              Colors.green);
                        }));
                      }
                    }
                  },
                  child: Text("Fini"))
            ])));
  }
}

class EndScreen extends StatelessWidget {
  var resultat = "";
  var message = "";
  var couleur = Colors.green;

  EndScreen(result, msg, color) {
    this.resultat = result;
    this.couleur = color;
    this.message = msg;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Résultats")),
        body: Container(
            child: Column(children: [
          FittedBox(
              child: Hero(
                  tag: "Logo",
                  child: Container(
                      child: Image.network(
                          "https://www.collegeboreal.ca/static/assets/img/logo-black.png"),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 60)))),
          Text(this.resultat,
              style:
                  TextStyle(color: this.couleur, fontWeight: FontWeight.bold)),
          Text(this.message)
        ])));
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revision',
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Revision'),
      debugShowCheckedModeBanner: false,


    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool genre = true;
  double taillebase = 0.0;
  double? poids;
  double? age;
  double Sliderdouble = 0.0;
  int poidsbase = 50;
  int agebase = 18;
  double? caloriebase;
  double? calorieavecActivite;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("BMI CALCULATOR"),
      ),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Card(
                    color: Color(
                        0xFF6CB07A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    child: Container(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            genre = true;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.man,size: 100,color: Colors.white,),
                            new Text("Homme",style: TextStyle(fontSize: 50,color: Colors.white),)
                          ],
                        ),
                      ),
                      width: MediaQuery.of(context).size.width/2.2,
                        height: 200,

                    ),
                  ),
                  Card(
                    color: Color(
                        0xFF6CB07A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    child: Container(
                      child: InkWell(
                        onTap: (){
                          genre = false;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.woman,size: 100,color: Colors.white,),
                            new Text("Femme",style: TextStyle(fontSize: 50,color: Colors.white),)
                          ],
                        ),
                      ),
                        width: MediaQuery.of(context).size.width/2.2,
                        height: 200,

                    ),
                  ),
                ],
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Card(
                    color: Color(
                        0xFF6CB07A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    child: Container(
                      child: Column
                        (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Text("${Sliderdouble.toInt()}",style: TextStyle(fontSize: 40,color: Colors.white),),
                              new Text("cm",style: TextStyle(fontSize: 15,color: Colors.white),),

                            ],
                          ),

                          new Slider(
                            activeColor: Colors.pink,
                            inactiveColor: Colors.black,

                            min: 0.0,
                              max: 220.0,
                              value: Sliderdouble,
                              divisions: 100,
                              onChanged: (double d){
                                setState(() {
                                  taillebase = d;
                                  Sliderdouble = d;
                                });
                              })
                        ],
                      ),
                      width: MediaQuery.of(context).size.width-20,
                      height: 200,


                    ),
                  )

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Card(
                    color: Color(
                        0xFF6CB07A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Text("Poids",style: TextStyle(fontSize: 40,color: Colors.white),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Text("$poidsbase",style: TextStyle(fontSize: 50,color: Colors.white),),
                              new Text("KG",style: TextStyle(fontSize: 15,color: Colors.white),),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child:InkWell(
                                  onTap:(){
                                    setState(() {
                                      poidsbase++;
                                    });
                    },
                                  child: Icon(Icons.add),
                                ),
                              ),
                              Card(
                                child:InkWell(
                                  onTap:(){
                                    setState(() {
                                      poidsbase--;
                                    });
                                  },
                                  child: Icon(Icons.exposure_minus_1),
                                ),
                              ),
                            ],
                          )
                          ],
                      ),
                        width: MediaQuery.of(context).size.width/2.2,
                        height: 200,

                    ),
                  ),
                  Card(

                    color: Color(
                        0xFF6CB07A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Text("Age",style: TextStyle(fontSize: 40,color: Colors.white),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Text("$agebase",style: TextStyle(fontSize: 50,color: Colors.white),),
                              new Text("ans",style: TextStyle(fontSize: 15,color: Colors.white),),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child:InkWell(
                                  onTap:(){
                                    setState(() {
                                      agebase++;
                                    });
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ),
                              Card(
                                child:InkWell(
                                  onTap:(){
                                    setState(() {
                                      agebase--;
                                    });
                                  },
                                  child: Icon(Icons.exposure_minus_1),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      width: MediaQuery.of(context).size.width/2.2,
                      height: 200,

                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Card(
                    color: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),),
                    child: InkWell(
                      onTap: (){
                        print("CALCULE");
                        alert();
                      },
                      child: Container(

                        width: MediaQuery.of(context).size.width-20,
                        height: MediaQuery.of(context).size.height/8,
                        color: Colors.pink,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text("CALULER BMI",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),),
                            )
                          ],
                        ),

                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Null> alert ()async{
    return showDialog(context: context,
        builder: (BuildContext buidlcontext){
        return SimpleDialog(
          title: Text("Calcule du BMI"),
          titlePadding: EdgeInsets.only(left: 70,top: 20),
          children: [
            Column(
              children: [
                Text("Apres calcul votre besoins de base en calories est de :${calculBMI(genre, poidsbase, taillebase, agebase)}"),

              ],
            )
          ],
          contentPadding: EdgeInsets.all(50),

        );
    });
  }

  double calculBMI(bool genre,int poids,double taille,int age){
    double? calorie = 0;
    if(genre == true){
      calorie = 66.4730 + (13.7516 * poids) + (5.0033 * taille) - (6.7550 * age);
    }if(genre == false){
      calorie =  655.0955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age);
    }
    return calorie;
  }
}


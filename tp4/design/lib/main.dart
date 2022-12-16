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
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Design'),
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


  @override
  List Image = ["assets/dice1.png","assets/dice2.png","assets/dice3.png","assets/dice4.png","assets/dice5.png","assets/dice6.png"];

  int nombre1 = 5;
  int nombre2 = 0;
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      body: Container(

        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(

                          Image[nombre1]
                        ),
                        fit: BoxFit.cover
                    )
                ),

                child:
                InkWell(
                  onTap:(){
                    setState(() {
                      nombre1 = randomNumber();
                      nombre2 = randomNumber();
                    });


                  },
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                width: 150,
                height: 150,
                child:
                InkWell(
                  onTap:(){

                    setState(() {
                      nombre1 = randomNumber();
                      nombre2 = randomNumber();
                    });

                  },
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            Image[nombre2]
                        ),
                        fit: BoxFit.cover
                    )
                ),
              )
            ],
          )],
        ),
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );


  }

  int randomNumber() {
    var random = new Random();

    int min = 0;

    int max = 6;

    int result = min + random.nextInt(max - min);

    return result;
  }
}

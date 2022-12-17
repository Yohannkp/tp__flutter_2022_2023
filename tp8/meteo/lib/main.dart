
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder2/geocoder2.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      home: const MyHomePage(title: 'Meteo'),
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
    String key = "villes";
    List<String> villes = [];
    String villechoisie = "";
    Coordinates ?coordvillechoisie;
    Location location = new Location();
    late LocationData locationData;
    Stream<LocationData> ?stream;

    @override
    void initState(){
      super.initState();
      obtenir();

      getFirstLocation();
      listentostream();
    }

    getFirstLocation() async{
      try{
        LocationData locationData = await location.getLocation();
        print("Nouvelle position : ${locationData.latitude} / ${locationData.longitude}");
        locationtoString();
      }
      catch (e){
        print("Nous avons une erreur : $e");
      }
    }

    listentostream(){
      stream = location.onLocationChanged;
      stream?.listen((event) {
        print("Nouvelle emplacement => ${event.latitude} ----- ${event.longitude}");
        if((locationData == null) || (event.longitude != locationData.longitude) && (event.latitude != locationData.latitude)){
        setState(() {
          locationData = event;
          locationtoString();
        }
            );}
      });
    }

    coordsFormCity()async{
      if(villechoisie != null){
        List<Address> addresses = await Geocoder.local.findAddressesFromQuery(villechoisie);
        if(addresses.length> 0){
          Address first = addresses.first;
          Coordinates coordinates = first.coordinates;
          setState(() {
            coordvillechoisie = coordinates;

          });
        }
      }
    }


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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,

      ),
      drawer: new Drawer(
        child: new Container(
          color: Colors.blue,


          child: new ListView.builder(

              itemCount: villes.length+2,

              itemBuilder: (context,iteration) {
                if(iteration == 0){
                  return DrawerHeader(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textavecstyle("Mes villes",fontSize: 22.0),
                      new TextButton(onPressed: (){
                        print("Ajout d'une ville");
                        dialogue();

                      },
                          child: new Card(
                        elevation: 10,

                        color: Colors.white,
                        child: new Container(
                          padding: EdgeInsets.all(10),
                          child: textavecstyle("Ajouter une ville",color: Colors.blue),
                        ),
                      ))
                    ],
                  )
                  );
                } else if (iteration == 1){
                  return new ListTile(
                    title: textavecstyle("Ma ville actuelle"),
                    onTap: (){
                      setState(() {
                        villechoisie = "";
                        Navigator.pop(context);
                      });
                    },
                  );
                }else {
                  String ville = villes[iteration -2];
                  return new ListTile(
                    title: textavecstyle(villes[iteration-2]),
                    trailing: new IconButton(onPressed: (){
                      supprimer(ville);
                    }, icon: new Icon(Icons.delete,color: Colors.white,)),
                    onTap: (){
                      setState(() {
                        villechoisie = villes[iteration-2];
                        coordsFormCity();
                        Navigator.pop(context);
                      });
                    },
                  );
                }

          }),
        ),
      ),
      body: Center(
        child: new Text((villechoisie == "")? "Ville actuelle": villechoisie),
      ),
      );
  }

  Text textavecstyle(String data, {color:Colors.white,fontSize: 20.0,fontStyle:FontStyle.italic}) {
    return new Text(data,
      style: new TextStyle(color: color,fontStyle: fontStyle,fontSize: fontSize,),
    );
  }

  Future<Null> ajoutVille() async {
    return showDialog(
      barrierDismissible: true,
      builder: (BuildContext buildcontext){
        return new SimpleDialog(
          contentPadding: EdgeInsets.all(20),
          title: textavecstyle("Ajouter une ville", fontSize: 22,color: Colors.blue),
          children: [
            new TextField(
              decoration: new InputDecoration(labelText: "ville"),
              onSubmitted: (String str){
                ajouter(str);
                Navigator.pop(buildcontext);
              },
            )
          ],
        );
      },
      context: context
    );
  }
  void obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? liste = await sharedPreferences.getStringList(key);
    if (liste != null){
      setState(() {
        villes = liste;
      });
    }
  }

  void supprimer(String str) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    villes.remove(str);
    await sharedPreferences.setStringList(key, villes);
    obtenir();
  }

  void ajouter(String str) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    villes.add(str);
    await sharedPreferences.setStringList(key, villes);
    obtenir();
  }

    Future<Null> dialogue() async{

      return showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return new SimpleDialog(
              title: new Text("Ajout d'une ville",style: TextStyle(color:Colors.blue),),
              contentPadding: EdgeInsets.all(20.0),
              children: [
                new TextField(
                  decoration: new InputDecoration(labelText: "ville"),
                  onSubmitted: (String str){
                    ajouter(str);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    locationtoString()async{
      if(locationData != null) {
        Coordinates coordinates = new Coordinates(locationData.latitude, locationData.longitude);
        final cityName = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        print(cityName.first.locality);
      }
    }

    void appelApi() async {

      List<Address> coord = await Geocoder.local.findAddressesFromQuery(villechoisie);
      if (coord != null) {
        final lat = coord.first.coordinates.latitude;
        final lon = coord.first.coordinates.longitude;
        String lang = Localizations.localeOf(context).languageCode;
        final key = "&APPID=4af023570d0827fd2d5bd9ca7a3e6d42";

        String urlApi = "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=$lang&APPID=$key";

        final reponse = await http.get(urlApi);
        if (reponse.statusCode == 200) {
          /*Temps temps = new Temps();
          Map map = json.decode(reponse.body);
          temps.fromJSON(map);
          setState(() {
            tempsActuel = temps;
          });
        */}
      }
    }

}

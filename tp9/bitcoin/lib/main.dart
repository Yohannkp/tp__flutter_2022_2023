import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Ticker',
      home: TickerScreen(),
    );
  }
}

class TickerScreen extends StatefulWidget {
  @override
  _TickerScreenState createState() => _TickerScreenState();
}

class _TickerScreenState extends State<TickerScreen> {

  late Map tickerData;

  @override
  void initState() {
    super.initState();


    _loadTickerData();


    Timer.periodic(Duration(seconds: 30), (timer) {
      _loadTickerData();
    });
  }


  _loadTickerData() async {
    // Envoi de la requête HTTP vers l'API de données de prix de Bitcoin
    final response = await http.get(
      'https://api.coinmarketcap.com/v2/ticker/1/',
    );


    final tickerJson = jsonDecode(response.body);
    final ticker = tickerJson['data'];


    setState(() {
      tickerData = ticker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Ticker'),
      ),
      body: Center(
        child: tickerData == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${tickerData['quotes']['USD']['price']}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${tickerData['quotes']['USD']['percent_change_24h']}% (24h)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
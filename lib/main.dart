import 'package:flutter/material.dart';
import 'package:mycryptostats/api.dart';
import 'package:mycryptostats/coin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Crypto Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Crypto Wiki'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This is the first screen to be viwed

  bool refreshed = false;
  List<Coin> coins;
  Widget actual = CircularProgressIndicator();

  Future<Widget> getAllCoins(String tipo) async {
    Coin listita = await getCoins(tipo);
    print("lenght ${listita.coinsList.length}");
    List<Widget> cards = new List<Widget>(); // Contains tthe list of the cards
    for (int i = 0; i < listita.coinsList.length; i++) {
      // Create a card for each Coin
      cards.add(Card(
        color: Colors.amber[600],
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // First upper row
                children: <Widget>[
                  Text(
                    listita.coinsList[i].name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  listita.coinsList[i].isNew ? Icon(Icons.fiber_new) : Text(""),
                  listita.coinsList[i].isActive ? Icon(Icons.insert_chart, color: Colors.white, size: 20,) : Text(""),
                ],
              )
            ],
          ),
        ),
      ));
    }

    return ListView(
      children: cards,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!refreshed) {
      // executes only when needed
      getAllCoins('coins').then((valor) {
        actual = valor;
        setState(() {
          refreshed = true;
        });
      });
    }

    return Scaffold(
      appBar: new AppBar(title: Text("hey"), backgroundColor: Colors.amber),
      backgroundColor: Colors.amber[300],
      body: Center(
        child: actual,
      ),
    );
  }
}

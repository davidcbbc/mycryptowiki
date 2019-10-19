import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycryptostats/api.dart';
import 'package:mycryptostats/coin.dart';
import 'package:mycryptostats/second.dart';

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
  final Connectivity _connectivity = Connectivity();
  bool refreshed = false;
  List<Coin> coins;
  bool connected = true;
  Widget actual = CircularProgressIndicator();

  Future<bool> _checkNet() async {
    bool connect;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
      }
    } on SocketException catch (_) {
      connect = false;
    }
    return connect;
  }

  Future<Widget> getAllCoins(String tipo) async {
    Coin listita = await getCoins(tipo);
    print("lenght ${listita.coinsList.length}");
    List<Widget> cards = new List<Widget>(); // Contains tthe list of the cards
    for (int i = 0; i < listita.coinsList.length; i++) {
      // Create a card for each Coin
      cards.add(FlatButton(
        child: Card(
          color: Colors.amber[600],
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // First upper row
                  children: <Widget>[
                    Text(
                      listita.coinsList[i].rank.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.normal),
                    ),
                    Container(
                      // Contains Text and Icons form the middle
                      child: Row(
                        children: <Widget>[
                          Text(
                            listita.coinsList[i].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          listita.coinsList[i].isNew
                              ? Icon(Icons.fiber_new,
                                  color: Colors.white, size: 20)
                              : Text(""),
                          listita.coinsList[i].isActive
                              ? Icon(
                                  Icons.insert_chart,
                                  color: Colors.white,
                                  size: 20,
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                    listita.coinsList[i].type == 'coin'
                        ? Icon(
                            Icons.payment,
                            color: Colors.white,
                          )
                        : Icon(Icons.receipt, color: Colors.white)
                  ],
                ),
                Center(
                  child: Text(listita.coinsList[i].symbol,
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
        onPressed: () async {
          // Coin Pressed

          // Platform messages may fail, so we use a try/catch PlatformException.
          bool net = await _checkNet();
          if (net) {
            // has internet connection
              print("Pressed ${listita.coinsList[i].name}");
              Coin passing = await getCoinDetailed(listita.coinsList[i].coinId);
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Second(passing)));
            
          } else {
            // has no internet connection
            _showDialog(
                "Ups!",
                Text(
                  "Please check your connection and try again !",
                  style: TextStyle(color: Colors.white),
                ));
          }

          //_showDialog("Ups!", Text("Please check your connection and try again !", style: TextStyle(color: Colors.white),));

          //_showDialog("Ups!", Text("Something went wrong!", style: TextStyle(color: Colors.white),));
        },
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
      _checkNet().then((valor) {
        connected = valor;
        if (connected) {
          getAllCoins('coins').then((valor) {
            actual = valor;
            setState(() {
              refreshed = true;
            });
          });
        } else {
          setState(() {
            refreshed = true;
            connected = false;
          });
        }
      });
    }

    return Scaffold(
      appBar: new AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            onPressed: () {
              // Open the information alert
              Widget desc = Container(
                width: 100,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "My Crypto Wiki is an app where you can find useful information about crypto currencies such as their development teams , algorithms , and such.",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.fiber_new, color: Colors.white),
                        Text(
                          " New coin",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.insert_chart, color: Colors.white),
                        Text(
                          " Active",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.payment, color: Colors.white),
                        Text(
                          " Coin",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.receipt, color: Colors.white),
                        Text(
                          " Token",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              _showDialog("About", desc);
            },
          ),
          title: Text(
            "My Crypto Wiki",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          backgroundColor: Colors.amber[600]),
      backgroundColor: Colors.amber[300],
      body: refreshed
          ? connected
              ? Center(
                  child: actual,
                )
              : Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Please check your connection",
                            style: TextStyle(
                                color: Colors.amber[700], fontSize: 25)),
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.amber[700],
                          ),
                          onPressed: () {
                            setState(() {
                              refreshed = false;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _showDialog(String title, Widget description) {
    // Show a dialog message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.amber[800],
          title: new Text(
            title,
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          ),
          content: description,
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Alright",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  refreshed = false;
                });
              },
            ),
          ],
        );
      },
    );
  }
}

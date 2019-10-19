import 'package:flutter/material.dart';
import 'package:mycryptostats/coin.dart';
// this is the second screen

class Second extends StatelessWidget {
  Coin coin;
  Second(this.coin);


  Widget tagzita() {
    // Returns the tags 
    String interpolation = '';
    for( int i = 0 ; i < coin.tags.length ; i++ ){
      interpolation += '${coin.tags[i]} , ';
    }
    return new Text(interpolation, style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,);
  }

  Widget teamzita() {
    // Returns the team
    String interpolation = '';
    for( int i = 0 ; i < coin.team.length ; i++ ){
      interpolation += '${coin.team[i]['name']} , ${coin.team[i]['position']} \n';
    }
    return interpolation.isEmpty? Text('Unknow', style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,)
    : new Text(interpolation, style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name),
        backgroundColor: Colors.amber[600],
      ),
      backgroundColor: Colors.amber[300],
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20,),
              Text(coin.symbol, style: TextStyle(color: Colors.amber[800], fontSize: 50, fontWeight: FontWeight.bold),),
              Text(coin.rank.toString(), style: TextStyle(color: Colors.amber[600], fontSize: 25),),
              tagzita(),
              SizedBox(height: 5,),
              coin.open_source? Text("Open Source", style: TextStyle(color: Colors.amber[700], fontSize: 20, fontWeight: FontWeight.bold),) : Text(""),
              SizedBox(height: 20,),
              Text("Description", style: TextStyle(color: Colors.amber[800] ,fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 10 ,  right: 10),
                child: Text(coin.description, style: TextStyle(color: Colors.amber[800] ,fontSize: 15), textAlign: TextAlign.center,),
              ),
              SizedBox(height: 30,),
              Text("Team", style: TextStyle(color: Colors.amber[800] ,fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              teamzita(),
              SizedBox(height: 30,),
              Text("Started", style: TextStyle(color: Colors.amber[800] ,fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              coin.start != 'null' && coin.start != null? Text(coin.start, style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,) :
              Text('Unknow', style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,) ,
              SizedBox(height: 30,),
              Text("Hash Algorithm", style: TextStyle(color: Colors.amber[800] ,fontSize: 15, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              coin.hash_algorithm != null? Text(coin.hash_algorithm, style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,) :
              Text('None', style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Text("Structure", style: TextStyle(color: Colors.amber[800] ,fontSize: 15, fontWeight: FontWeight.bold),),
              Text(coin.structure, style: TextStyle(color: Colors.amber[800]), textAlign: TextAlign.center,),
              SizedBox(height: 30,),



            ],
          )
        ],
      ),
    );
  }



}
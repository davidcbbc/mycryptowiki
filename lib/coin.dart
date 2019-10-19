class Coin {
  String name;
  String symbol;
  int rank;
  bool isNew;
  bool isActive;
  String type;
  List<Coin> coinsList;


  Coin(this.name,this.symbol,this.rank,this.isNew,this.isActive,this.type);
  Coin.toList(this.coinsList);

  factory Coin.fromJson(dynamic json) {
    // Calls a contructor to create a new instance of coin
    //print(json.toString());
    List hey = json;
    List<Coin> list = new List<Coin>();
    for( int i = 0 ; i < 20 ; i++) {
      // Checks the first 20 positions of the rank
      print(hey[i]['name'].toString());
      list.add(Coin(
        hey[i]['name'].toString(),
        hey[i]['symbol'].toString(),
        int.parse(hey[i]['rank'].toString()),
        hey[i]['is_new'],
        hey[i]['is_active'],
        hey[i]['type'].toString()
      ));
    }
    return Coin.toList(list);

  }

}
class Coin {
  String name;
  String symbol;
  String coinId;
  int rank;
  bool isNew;
  bool isActive;
  String type;
  List<Coin> coinsList;

  // -- detailed --

  List<String> tags;
  List<Map<String, String>> team;
  String description;
  bool open_source;
  String start;
  String hash_algorithm;
  String structure;

  Coin.detailed(
      this.name,
      this.symbol,
      this.rank,
      this.tags,
      this.team,
      this.description,
      this.open_source,
      this.start,
      this.hash_algorithm,
      this.structure);

  Coin(this.name, this.symbol, this.rank, this.isNew, this.isActive, this.type, {this.coinId});
  Coin.toList(this.coinsList);

  factory Coin.fromJson(dynamic json) {
    // Calls a contructor to create a new instance of coin
    //print(json.toString());
    List hey = json;
    List<Coin> list = new List<Coin>();
    for (int i = 0; i < 20; i++) {
      // Checks the first 20 positions of the rank
      //print(hey[i]['name'].toString());
      list.add(Coin(
          hey[i]['name'].toString(),
          hey[i]['symbol'].toString(),
          int.parse(hey[i]['rank'].toString()),
          hey[i]['is_new'],
          hey[i]['is_active'],
          hey[i]['type'].toString(),
          coinId: hey[i]['id'].toString()));
    }
    return Coin.toList(list);
  }

  factory Coin.fromJsonDetailed(dynamic json) {
    // Create a instance of Coin for a detailed version
    Map hey = json;

    List<String> tags = new List<String>();
    List<Map<String, String>> team = new List<Map<String, String>>();

    String name = hey['name'].toString();
    String symbol = hey['symbol'].toString();
    int rank = int.parse(hey['rank'].toString());
    String description = hey['description'].toString();
    bool open_source = hey['open_source'];
    String start = hey['started_at'].toString();
    String hash_algorithm = hey['hash_algorithm'].toString();
    String structure = hey['org_structure'].toString();
    print('name $name \n symbol $symbol \n rank $rank \n description $description \n open_source $open_source \n start $start \n hash_algrithm $hash_algorithm \n structure $structure \n');


    List tagsAux = hey['tags'];
    //print("tags");
    for (int i = 0; i < tagsAux.length; i++){ 
      //print(tagsAux[i]['name'].toString());
      tags.add(tagsAux[i]['name'].toString()); // Tags loop
    }
      
    List teamAux = hey['team'];
    //print("team");
    for (int i = 0; i < teamAux.length; i++) {
      // Team loop
      Map<String, String> position = new Map<String, String>();
      position['name'] = teamAux[i]['name'].toString();
      position['position'] = teamAux[i]['position'].toString();
      //print("name ${position['name']} , position ${position['position']}");
      team.add(position);
    }

  
    return Coin.detailed(name, symbol, rank, tags, team, description,
        open_source, start, hash_algorithm, structure);
  }
}

// This page uses the API methods
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'coin.dart';

String url = 'https://api.coinpaprika.com/v1/';


Future<Coin> getCoins(String value) async{

return http.get(url + value).then((http.Response response) {
    final int statusCode = response.statusCode;
    print('Status Code : $statusCode ');
    if(statusCode < 200 || statusCode >= 400 || json == null) {
      throw new Exception('Error while fetching data on getCoins() ');
    }
    return Coin.fromJson(json.decode(response.body));       // Serializes the response to get an instance from Coin
  });

  
}










import 'dart:convert';

import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const myApiKey = '';

class CoinData {
  Future<dynamic> getCoinData(
      {required String coin, required String currency}) async {
    String readyUrl = _setCoinAndCurrency(coin, currency);

    Response response = await get(Uri.parse(readyUrl));

    return jsonDecode(response.body);
  }

  String _setCoinAndCurrency(String coin, String currency) {
    var url =
        'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=$myApiKey';
    return url;
  }
}

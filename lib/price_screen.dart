import 'dart:io' show Platform; //Used to check the platform.
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Using apple style and widgets
import 'package:bitcoind_ticker_project/coin_data.dart';

CoinData coinData = CoinData();

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String? bitCoinRate;
  String? ethCoinRate;
  String? ltcCoinRate;

  Future<void> updateRates(String currency) async {
    var btcRate = await coinData.getCoinData(coin: 'BTC', currency: currency);
    var ethRate = await coinData.getCoinData(coin: 'ETH', currency: currency);
    var ltcRate = await coinData.getCoinData(coin: 'LTC', currency: currency);

    setState(() {
      selectedCurrency = currency;
      bitCoinRate = btcRate['rate'].toStringAsFixed(2);
      ethCoinRate = ethRate['rate'].toStringAsFixed(2);
      ltcCoinRate = ltcRate['rate'].toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    updateRates(selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${bitCoinRate} ${selectedCurrency}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethCoinRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcCoinRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 80.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? DropdownButton<String>(
                    value: selectedCurrency,
                    items: currenciesList
                        .map((String e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) async {
                      await updateRates(value!);
                    },
                    menuMaxHeight: 150.0,
                  )
                : Platform.isIOS
                    ? CupertinoPicker(
                        itemExtent: 32.0,
                        onSelectedItemChanged: (selectedIndex) =>
                            print(selectedIndex),
                        children:
                            currenciesList.map((String e) => Text(e)).toList(),
                      )
                    : null,
          ),
        ],
      ),
    );
  }
}

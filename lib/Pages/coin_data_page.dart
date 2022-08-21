import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Model/coin_data_page_model.dart';
import '../Provider/coin_data_page_provider.dart';

class CoinDataPage extends StatefulWidget {
  const CoinDataPage({super.key});

  @override
  State<CoinDataPage> createState() => _CoinDataPageState();
}

class _CoinDataPageState extends State<CoinDataPage> {
  @override
  void initState() {
    super.initState();
    final coinModel = Provider.of<CoinDataPageProvider>(context, listen: false);
    coinModel.fetchCoins();
  }

  @override
  Widget build(BuildContext context) {
    final coinModel = Provider.of<CoinDataPageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(90),
          child: Text('Coin List'),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              TextField(
                onChanged: (value) => coinModel.filterCoin(value),
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: coinModel.foundcoins?.length,
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: CoinDataListView(
                              index: index, data: coinModel.foundcoins!),
                        )),
              ),
            ],
          )),
    );
  }
}

//all view

class CoinDataListView extends StatelessWidget {
  const CoinDataListView({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  final int index;
  final List<CoinList> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 30,
                    child: data[index].logoUrl.endsWith("svg")
                        ? SvgPicture.network(
                            data[index].logoUrl,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            data[index].logoUrl,
                            fit: BoxFit.fill,
                          ))
              ],
            )),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data[index].id),
                Text("${data[index].rank}.${data[index].id}"),
              ],
            )),
        const VerticalDivider(),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("\$${_price(data[index].price)}"),
                Text("\$${_milionBilion(data[index].marketCap)}"),
              ],
            )),
        const VerticalDivider(),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    data[index].the1D.priceChangePct.contains("-")
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: data[index].the1D.priceChangePct.contains("-")
                        ? Colors.red
                        : Colors.green,
                  ),
                  Text(
                    data[index].the1D.priceChangePct.contains("-")
                        ? ("\$${data[index].the1D.priceChangePct}")
                        : ("\$${data[index].the1D.priceChangePct}"),
                    style: TextStyle(
                      color: data[index].the1D.priceChangePct.contains("-")
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text("\$${(data[index].the1D.volume)}"),
            ],
          ),
        )
      ],
    );
  }
}

//data number handle

_milionBilion(String marketcap) {
  String newMarketcap;
  if (6 >= marketcap.length) {
    newMarketcap = '${marketcap.substring(0, 3)}M';
  } else {
    newMarketcap = '${marketcap.substring(0, (marketcap.length - 9))}B';
  }
  return newMarketcap;
}

_price(String price) {
  String newPrice;
  newPrice = double.parse(price).toStringAsFixed(3);
  return newPrice;
}
